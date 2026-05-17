import logging
from typing import ClassVar

from beet import (
    Context,
    NamespaceFileScope,
    TextFile,
    Texture,
)
from PIL import Image


class MarkerAsset(TextFile):
    scope: ClassVar[NamespaceFileScope] = ("textures",)
    extension: ClassVar[str] = ".marker"


logger = logging.getLogger(__name__)


def beet_default(ctx: Context):
    ctx.assets.extend_namespace.append(MarkerAsset)

    yield

    marker_assets: dict[str, MarkerAsset] = ctx.assets[MarkerAsset]

    for path, marker in marker_assets.items():
        pixels: list[int] = []
        lines = marker.text.strip().splitlines()

        for line in lines:
            _, *values = line.split()
            if len(values) != 4:
                raise ValueError(f"Invalid RGBA definition in {path}: {line}")
            pixels.extend(map(int, values))

        width = len(lines)
        height = 1

        img = Image.frombytes("RGBA", (width, height), bytes(pixels))

        ctx.assets.textures[path] = Texture(img)

    ctx.assets[MarkerAsset].clear()
