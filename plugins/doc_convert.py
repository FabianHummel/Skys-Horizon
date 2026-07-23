import logging
import os
import subprocess
import sys
import tempfile
from io import BytesIO
from typing import ClassVar

from beet import (
    BinaryFile,
    Context,
    ErrorMessage,
    NamespaceFileScope,
    Texture,
)

from plugins.beet_utils import beet_run_threaded


class DocxDocument(BinaryFile):
    scope: ClassVar[NamespaceFileScope] = ("textures",)
    extension: ClassVar[str] = ".docx"


logger = logging.getLogger(__name__)


def beet_default(ctx: Context):
    ctx.assets.extend_namespace.append(DocxDocument)

    config = ctx.meta.get("doc_convert", {})
    tool = config.get("tool", "libreoffice").lower()

    yield

    documents: dict[str, DocxDocument] = ctx.assets[DocxDocument]

    results = beet_run_threaded(config, documents, process_single_document, tool)

    for path, images in results.items():
        if len(images) == 1:
            ctx.assets.textures[f"{path}"] = Texture(images[0])
        else:
            for i, image in enumerate(images):
                ctx.assets.textures[f"{path}_{i}"] = Texture(image)

    ctx.assets[DocxDocument].clear()


def _convert_docx_to_pdf_msword_windows(input_path: str, pdf_path: str):
    """native Word-export under Windows via COM-Interface."""
    import win32com.client

    word = win32com.client.Dispatch("Word.Application")
    word.Visible = False
    try:
        doc = word.Documents.Open(os.path.abspath(input_path))
        doc.SaveAs(os.path.abspath(pdf_path), FileFormat=17)  # 17 = wdFormatPDF
        doc.Close()
    finally:
        word.Quit()


def _convert_docx_to_pdf_msword_macos(input_path: str, pdf_path: str):
    """native Word-export under macOS via AppleScript (osascript)."""
    abs_input = os.path.abspath(input_path)
    abs_output = os.path.abspath(pdf_path)

    # AppleScript that opens Microsoft Word in the background, converts the document and closes
    applescript = f'''
    tell application "Microsoft Word"
        set openDoc to open file name "{abs_input}"
        save as openDoc file name "{abs_output}" file format format PDF
        close openDoc saving no
        quit
    end tell
    '''

    # execute the AppleScript via the macOS command line
    process = subprocess.run(
        ["osascript", "-e", applescript], capture_output=True, text=True
    )

    if process.returncode != 0:
        raise ErrorMessage(f"macOS Word-conversion failed: {process.stderr}")


def convert_docx_to_pdf(tool: str, input_path: str, pdf_path: str, tmpdir: str):
    """determines routing for the correct conversion based on the selected tool and platform."""
    if tool == "msword":
        if sys.platform == "win32":
            _convert_docx_to_pdf_msword_windows(input_path, pdf_path)
        elif sys.platform == "darwin":
            _convert_docx_to_pdf_msword_macos(input_path, pdf_path)
        else:
            raise ErrorMessage(
                f"'msword' is not supported on the platform '{sys.platform}'."
            )

    elif tool == "libreoffice":
        cmd = [
            "soffice",
            "--headless",
            "--convert-to",
            "pdf",
            input_path,
            "--outdir",
            tmpdir,
        ]
        subprocess.run(cmd, check=True, stdout=subprocess.DEVNULL)
    else:
        raise ErrorMessage(f"Invalid tool configured: '{tool}'")


def process_single_document(path: str, asset: DocxDocument, tool: str) -> list[bytes]:
    logger.info(f' → Converting "{path}"')

    png_outputs = []

    # Path to the officially shared group-sandbox-folder from Microsoft Office on the Mac
    mac_office_sandbox = os.path.expanduser(
        "~/Library/Group Containers/UBF8T346G9.Office"
    )

    # Check if we are on macos and the folder exists
    if os.name == "posix" and os.path.exists(mac_office_sandbox):
        ctx_dir = tempfile.TemporaryDirectory(dir=mac_office_sandbox)
    else:
        # fallback for Windows/other systems
        ctx_dir = tempfile.TemporaryDirectory()

    with ctx_dir as tmpdir:
        input_path = os.path.join(tmpdir, "document.docx")
        pdf_path = os.path.join(tmpdir, "document.pdf")

        with open(input_path, "wb") as f:
            f.write(asset.blob)

        # DOCX -> PDF
        convert_docx_to_pdf(tool, input_path, pdf_path, tmpdir)

        # PDF -> PNG
        from pdf2image import convert_from_path

        images = convert_from_path(pdf_path, dpi=300)

        for image in images:
            img_byte_arr = BytesIO()
            image.save(img_byte_arr, format="PNG")
            png_outputs.append(img_byte_arr.getvalue())

    return png_outputs
