import logging
import subprocess
import tempfile
from pathlib import Path
from typing import ClassVar

from beet import (
    Context,
    ErrorMessage,
    NamespaceFileScope,
    TextFile,
    Texture,
)

from plugins.beet_utils import beet_run_threaded


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

    results = beet_run_threaded(
        config, aseprite_assets, convert_asset, ctx, binary_path
    )

    for path, asset in results.items():
        ctx.assets.textures[path] = asset

    ctx.assets[AsepriteAsset].clear()


def convert_asset(
    path: str,
    asset: AsepriteAsset,
    ctx: Context,
    bin: str,
) -> Texture:
    logger.info(f' → Converting "{path}"')

    output_texture_tmp = tempfile.NamedTemporaryFile(suffix=".png", delete=False)
    output_texture_path = Path(output_texture_tmp.name)
    output_texture_tmp.close()

    try:
        subprocess.run(
            args=[bin, "-b", asset.source_path, "--save-as", str(output_texture_path)],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.PIPE,
            text=True,
        )

        bytes = Texture.from_path(output_texture_path, 0, -1)

        return Texture(bytes)

    except subprocess.CalledProcessError as e:
        raise ErrorMessage(e.stderr.strip())

    finally:
        output_texture_path.unlink(missing_ok=True)
