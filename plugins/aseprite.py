import logging
import subprocess
from hashlib import sha256
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

    for path, asset in aseprite_assets.items():
        ctx.assets.textures[path] = convert_asset(path, asset, ctx, binary_path)

    ctx.assets[AsepriteAsset].clear()


def convert_asset(
    path: str,
    asset: AsepriteAsset,
    ctx: Context,
    bin: str,
) -> Texture:
    cache = ctx.cache.get(__name__)

    cached_asset_path = cache.directory / sha256(path.encode("utf-8")).hexdigest()
    cached_asset_path = cached_asset_path.with_suffix(".png")

    if not cache.has_changed(asset.source_path) and cached_asset_path.exists():
        return Texture(source_path=cached_asset_path)

    logger.info(f' → Converting "{path}"')

    try:
        subprocess.run(
            args=[bin, "-b", asset.source_path, "--save-as", str(cached_asset_path)],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.PIPE,
            text=True,
        )

        bytes = Texture.from_path(cached_asset_path, 0, -1)

        return Texture(bytes)

    except subprocess.CalledProcessError as e:
        raise ErrorMessage(e.stderr.strip())
