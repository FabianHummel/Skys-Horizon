import logging
import re
from typing import ClassVar

from beet import (
    Context,
    ErrorMessage,
    NamespaceFileScope,
    TextFile,
    Function,
)


class DialogDefinition(TextFile):
    scope: ClassVar[NamespaceFileScope] = ("function",)
    extension: ClassVar[str] = ".dialog"


class Participant:
    name: str
    color: str
    rate: float


class FlowElement:
    data: str


class Paragraph(FlowElement):
    participant: str
    sound: str
    duration: float

    def __init__(self, participant):
        self.participant = participant


class Dialog:
    participants: dict[str, Participant]
    flow: list[FlowElement]


logger = logging.getLogger(__name__)


def beet_default(ctx: Context):
    ctx.data.extend_namespace.append(DialogDefinition)

    yield

    dialog_definitions: dict[str, DialogDefinition] = ctx.data[DialogDefinition]

    for path, definition in dialog_definitions.items():
        lines = definition.text.splitlines()

        dialog = Dialog()

        last_entry = None

        for line in lines:
            participant = re.search("(?<=^participant\s)[a-z-_]*(?=:)")
            if participant is not None:
                participant_id = participant.group()
                dialog.participants[participant_id] = last_entry = Participant()

            paragraph = re.search("(?<=^paragraph\s)[a-z-_]*(?=:)")
            if paragraph is not None:
                participant_id = paragraph.group()
                flow_element = last_entry = Paragraph(participant_id)
                dialog.flow.append(flow_element)

            property = re.search(".+:.+")
            if property is not None:
                if last_entry is None:
                    raise ErrorMessage("Properties need to be declared within a definition.")
                key, value = [x.strip() for x in property.group().split(':')]
                if not hasattr(last_entry, key):
                    raise ErrorMessage(f"{type(last_entry).__name__} definition does not have a property '{key}'.")
                setattr(last_entry, key, value)

        ctx.data.functions[path] = Function(generate_code_for_dialog(dialog))

    ctx.data[DialogDefinition].clear()


def generate_code_for_dialog(dialog: Dialog):
    return ""