import logging
import os
import re
import subprocess
import tempfile
from pathlib import Path
from typing import ClassVar, Optional

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


def register_objs(ctx: Context):
    ctx.assets.extend_namespace.append(ObjAsset)


logger = logging.getLogger(__name__)
is_animation_pattern = r"(?:^|[/:])0$"


def beet_default(ctx: Context):
    meta = ctx.meta.get("objmc")
    bin = meta.get("binary") or "objmc-rs"
    obj_assets: dict[str, ObjAsset] = ctx.assets[ObjAsset]
    skipping = None
    for path, obj in obj_assets.items():
        if skipping and path.startswith(skipping):
            continue
        else:
            skipping = None

        obj_path = obj.source_path

        is_animation = bool(re.search(is_animation_pattern, path))
        if is_animation:
            path = path[:-2]
            obj_path = os.path.dirname(obj_path)
            skipping = path

        # objmc texture is always in "item" folder for Sky's Horizon
        tex_ns = path.replace(":", ":item/")
        tex = ctx.assets.textures.get(tex_ns)
        if tex is None:
            raise ErrorMessage(
                f"Could not find matching texture ('{tex_ns}') for model '{path}'"
            )

        marker_value: Optional[int] = meta.get("markers").get(path)
        if marker_value is None:
            raise ErrorMessage(f"No marker value defined for model '{path}'")

        logger.info(f'Generating "{path}"')
        (model, texture) = invoke_objmc(
            bin, obj_path, tex.source_path, marker_value, tex_ns
        )

        ctx.assets.models[path] = model
        ctx.assets.textures[tex_ns] = texture

    remove_obj_resources(ctx)


def invoke_objmc(
    bin: str,
    obj_path: str,
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
                "--obj",
                obj_path,
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


def remove_obj_resources(ctx: Context):
    ctx.assets[ObjAsset].clear()
