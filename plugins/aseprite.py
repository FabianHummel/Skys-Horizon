import logging
import subprocess
import tempfile
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import ClassVar

from beet import (
    Context,
    ErrorMessage,
    NamespaceFileScope,
    TextFile,
    Texture,
)


class AsepriteAsset(TextFile):
    scope: ClassVar[NamespaceFileScope] = ("textures",)
    extension: ClassVar[str] = ".aseprite"


logger = logging.getLogger(__name__)


def beet_default(ctx: Context):
    ctx.assets.extend_namespace.append(AsepriteAsset)

    yield

    aseprite_assets: dict[str, AsepriteAsset] = ctx.assets[AsepriteAsset]

    config = ctx.meta.get("aseprite") or {}
    binary_path = config.get("binary_path") or "aseprite"
    max_workers = config.get("workers") or 8

    futures = {}

    with ThreadPoolExecutor(max_workers=max_workers) as executor:
        for path, asset in aseprite_assets.items():
            logger.info(f' → Converting "{path}"')
            future = executor.submit(
                invoke_aseprite,
                binary_path,
                asset.source_path,
            )
            futures[future] = path

        for future in as_completed(futures):
            path = futures[future]
            ctx.assets.textures[path] = future.result()

    ctx.assets[AsepriteAsset].clear()


def invoke_aseprite(
    bin: str,
    texture_path: str,
) -> Texture:
    output_texture_tmp = tempfile.NamedTemporaryFile(suffix=".png", delete=False)
    output_texture_path = Path(output_texture_tmp.name)
    output_texture_tmp.close()

    try:
        subprocess.run(
            args=[bin, "-b", texture_path, "--save-as", str(output_texture_path)],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.PIPE,
            text=True,
        )

        return Texture(Texture.from_path(output_texture_path, 0, -1))

    except subprocess.CalledProcessError as e:
        raise ErrorMessage(e.stderr.strip())

    finally:
        output_texture_path.unlink(missing_ok=True)
