import logging
import subprocess
import tempfile
from pathlib import Path
from typing import ClassVar

from beet import (
    Context,
    ErrorMessage,
    Model,
    NamespaceFileScope,
    TextFile,
    Texture,
)


class ObjAsset(TextFile):
    scope: ClassVar[NamespaceFileScope] = ("models",)
    extension: ClassVar[str] = ".obj"


logger = logging.getLogger(__name__)


def beet_default(ctx: Context):
    ctx.assets.extend_namespace.append(ObjAsset)

    yield

    meta = ctx.meta.get("objmc")
    bin = meta.get("binary") or "objmc-rs"
    models = meta.get("models")
    obj_assets: dict[str, ObjAsset] = ctx.assets[ObjAsset]

    for path, marker in models.items():
        try:
            source_paths = [obj_assets[path].source_path]
        except KeyError:
            source_paths = [
                item.source_path
                for key, item in obj_assets.items()
                if key.startswith(path)
            ]

        # objmc texture is always in "item" folder for Sky's Horizon
        tex_ns = path.replace(":", ":item/")
        tex = ctx.assets.textures.get(tex_ns)
        if tex is None:
            raise ErrorMessage(
                f"Could not find matching texture ('{tex_ns}') for model '{path}'"
            )

        if marker is None:
            raise ErrorMessage(f"No marker value defined for model '{path}'")

        logger.info(f' → Generating "{path}"')
        (json, texture) = invoke_objmc(
            bin, source_paths, tex.source_path, marker, tex_ns
        )

        ctx.assets.models[path] = json
        ctx.assets.textures[tex_ns] = texture

    ctx.assets[ObjAsset].clear()
    logger.info("Done.")


def invoke_objmc(
    bin: str,
    obj_paths: list[str],
    texture_path: str,
    marker_value: int,
    texture_namespace: str,
) -> (Model, Texture):
    output_model_tmp = tempfile.NamedTemporaryFile(suffix=".json", delete=False)
    output_model_path = Path(output_model_tmp.name)
    output_model_tmp.close()

    output_texture_tmp = tempfile.NamedTemporaryFile(suffix=".png", delete=False)
    output_texture_path = Path(output_texture_tmp.name)
    output_texture_tmp.close()

    try:
        subprocess.run(
            [
                bin,
                *[x for item in obj_paths for x in ("--objs", item)],
                "--texture",
                texture_path,
                "--marker",
                str(marker_value),
                "--output-model",
                str(output_model_path),
                "--output-texture",
                str(output_texture_path),
                "--texture-namespace",
                texture_namespace,
            ],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.PIPE,
            text=True,
        )

        return (
            Model(Model.from_path(output_model_path, 0, -1)),
            Texture(Texture.from_path(output_texture_path, 0, -1)),
        )

    except subprocess.CalledProcessError as e:
        raise ErrorMessage(e.stderr.strip())

    finally:
        output_model_path.unlink(missing_ok=True)
        output_texture_path.unlink(missing_ok=True)
