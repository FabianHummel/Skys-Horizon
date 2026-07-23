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

from plugins.beet_utils import beet_run_threaded


class ObjAsset(TextFile):
    scope: ClassVar[NamespaceFileScope] = ("models",)
    extension: ClassVar[str] = ".obj"


logger = logging.getLogger(__name__)


def beet_default(ctx: Context):
    ctx.assets.extend_namespace.append(ObjAsset)

    yield

    obj_assets: dict[str, ObjAsset] = ctx.assets[ObjAsset]

    config = ctx.meta.get("objmc") or {}
    bin = config.get("binary") or "objmc-rs"
    models = config.get("models") or {}

    results = beet_run_threaded(config, models, convert_asset, bin, obj_assets, ctx)

    for path, (model, texture, tex_ns) in results.items():
        ctx.assets.models[path] = model
        ctx.assets.textures[tex_ns] = texture

    ctx.assets[ObjAsset].clear()


def convert_asset(
    path: str, marker: int, bin: str, obj_assets: dict[str, ObjAsset], ctx: Context
) -> tuple[Model, Texture, str]:
    logger.info(f' → Generating "{path}"')

    try:
        source_paths = [obj_assets[path].source_path]
    except KeyError:
        source_paths = [
            item.source_path for key, item in obj_assets.items() if key.startswith(path)
        ]

    tex_ns = path.replace(":", ":item/")
    tex = ctx.assets.textures.get(tex_ns)
    if tex is None:
        raise ErrorMessage(
            f"Could not find matching texture ('{tex_ns}') for model '{path}'"
        )

    output_model_tmp = tempfile.NamedTemporaryFile(suffix=".json", delete=False)
    output_model_path = Path(output_model_tmp.name)
    output_model_tmp.close()

    output_texture_tmp = tempfile.NamedTemporaryFile(suffix=".png", delete=False)
    output_texture_path = Path(output_texture_tmp.name)
    output_texture_tmp.close()

    try:
        subprocess.run(
            args=[
                bin,
                *[x for item in source_paths for x in ("--objs", item)],
                "--texture",
                tex.source_path,
                "--marker",
                str(marker),
                "--output-model",
                str(output_model_path),
                "--output-texture",
                str(output_texture_path),
                "--texture-namespace",
                tex_ns,
            ],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.PIPE,
            text=True,
        )

        return (
            Model(Model.from_path(output_model_path, 0, -1)),
            Texture(Texture.from_path(output_texture_path, 0, -1)),
            tex_ns,
        )

    except subprocess.CalledProcessError as e:
        raise ErrorMessage(e.stderr.strip())

    finally:
        output_model_path.unlink(missing_ok=True)
        output_texture_path.unlink(missing_ok=True)
