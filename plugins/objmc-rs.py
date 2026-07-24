import logging
import subprocess
from hashlib import sha256
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

    obj_assets: dict[str, ObjAsset] = ctx.assets[ObjAsset]

    config = ctx.meta.get("objmc") or {}
    bin = config.get("binary") or "objmc-rs"
    models: dict[str, int] = config.get("models") or {}

    for path, marker in models.items():
        (model, texture, tex_ns) = convert_asset(path, marker, bin, obj_assets, ctx)
        ctx.assets.models[path] = model
        ctx.assets.textures[tex_ns] = texture

    ctx.assets[ObjAsset].clear()


def convert_asset(
    path: str, marker: int, bin: str, obj_assets: dict[str, ObjAsset], ctx: Context
) -> tuple[Model, Texture, str]:
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

    cache = ctx.cache.get(__name__)

    cached_asset_dir = cache.directory / sha256(path.encode("utf-8")).hexdigest()
    cached_model_dir = cached_asset_dir.with_suffix(".json")
    cached_texture_dir = cached_asset_dir.with_suffix(".png")

    if (
        not cache.has_changed(*source_paths, tex.source_path)
        and cached_model_dir.exists()
        and cached_texture_dir.exists()
    ):
        return (
            Model(source_path=cached_model_dir),
            Texture(source_path=cached_texture_dir),
            tex_ns,
        )

    logger.info(f' → Generating "{path}"')

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
                str(cached_model_dir),
                "--output-texture",
                str(cached_texture_dir),
                "--texture-namespace",
                tex_ns,
            ],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.PIPE,
            text=True,
        )

        return (
            Model(source_path=cached_model_dir),
            Texture(source_path=cached_texture_dir),
            tex_ns,
        )

    except subprocess.CalledProcessError as e:
        raise ErrorMessage(e.stderr.strip())
