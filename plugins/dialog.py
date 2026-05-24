import logging
import re
from itertools import accumulate
from textwrap import indent
from typing import ClassVar

from beet import (
    Context,
    ErrorMessage,
    Function,
    NamespaceFileScope,
    TextFile,
)


class DialogDefinition(TextFile):
    scope: ClassVar[NamespaceFileScope] = ("function",)
    extension: ClassVar[str] = ".dialog"


logger = logging.getLogger(__name__)


def beet_default(ctx: Context):
    ctx.data.extend_namespace.append(DialogDefinition)

    yield

    dialog_definitions: dict[str, DialogDefinition] = ctx.data[DialogDefinition]

    for path, definition in dialog_definitions.items():
        lines = [line.lstrip() for line in definition.text.splitlines()]
        dialog = Dialog()
        last_entry = None
        flow_stack = [dialog.flow]

        for line in lines:
            if line.startswith("#"):
                continue

            participant = re.search("(?<=^participant\\s)[a-zA-Z0-9-_]*(?=:)", line)
            if participant is not None:
                participant_id = participant.group()
                dialog.participants[participant_id] = last_entry = Participant()
                continue

            current_flow = flow_stack[-1]

            paragraph = re.search("(?<=^paragraph\\s)[a-zA-Z0-9-_]*(?=:)", line)
            if paragraph is not None:
                participant_id = paragraph.group()
                last_entry = Paragraph(participant_id)
                current_flow.append(last_entry)
                continue

            option = re.search("(?<=^option\\s)[a-zA-Z0-9-_]*(?=:)", line)
            if option is not None:
                choice_id = option.group()
                try:
                    last_choice = flow_stack[-2][-1]
                    if (
                        not isinstance(last_choice, Choice)
                        or choice_id != last_choice.id
                    ):
                        raise
                    else:
                        flow_stack.pop()
                except Exception:
                    last_choice = Choice(choice_id)
                    current_flow.append(last_choice)

                last_entry = Option()
                flow_stack.append(last_entry.flow)
                last_choice.options.append(last_entry)
                continue

            end_choice = re.search("^\\s*end choice$", line)
            if end_choice is not None:
                try:
                    last_choice = flow_stack[-2][-1]
                    if not isinstance(last_choice, Choice):
                        raise
                except Exception:
                    raise ErrorMessage(
                        "Cannot end choice without previously declaring at least one option."
                    )

                flow_stack.pop()
                continue

            property = re.search(".+:.+", line)
            if property is not None:
                if last_entry is None:
                    raise ErrorMessage(
                        "Properties need to be declared within a definition."
                    )
                key, value = [x.strip() for x in property.group().split(":", 1)]
                if not hasattr(last_entry, key):
                    raise ErrorMessage(
                        f"{type(last_entry).__name__} definition does not have a property '{key}'."
                    )
                setattr(last_entry, key, parse_property(key, value))

        ctx.data.functions[path] = Function(f"{dialog}")

    ctx.data[DialogDefinition].clear()


def parse_property(key: str, value: str):
    match key:
        case "rate":
            return float(value)

        case "duration":
            num = int(value[:-1])
            match value[-1]:
                case "t":
                    return num
                case "s":
                    return num * 20
                case _:
                    raise ErrorMessage(
                        "Duration signature must be either ticks (t) or seconds (s)."
                    )

        case "text":
            elements = re.findall(r'"[^"]*"|\{[^{}]*\}|\S+', value)
            try:
                parse_property("duration", elements[0])
            except ValueError:
                elements.insert(0, "0t")  # First element always starts at t=0
            times = list(
                accumulate(parse_property("duration", time) for time in elements[::2])
            )
            return list(zip(times, elements[1::2]))

        case _:
            return value


class Participant:
    name: str
    color: str
    rate: float

    def __init__(self) -> None:
        self.name = None
        self.color = None
        self.rate = 1.0

    def __str__(self) -> str:
        return f"""{{\\
    name: {self.name},\\
    color: {self.color},\\
    rate: {self.rate}\\
}}"""


class FlowElement:
    data: str

    def __init__(self) -> None:
        self.data = None


class Paragraph(FlowElement):
    participant: str
    sound: str
    text: list[tuple[int, str]]
    rate: float

    def __init__(self, participant):
        self.participant = participant
        self.sound = None
        self.text = []
        self.rate = 1.0

    def __str__(self) -> str:
        return f"""{{\\
    id: "paragraph",\\
    participant: "{self.participant}",\\{
            f'''
    sound: {self.sound},\\'''
            if self.sound is not None
            else ""
        }
    rate: {self.rate},\\
    timeline: [\\
{
            indent(
                ",\\\n".join(
                    f'''{{\\
    time: {time},\\
    text: {text}\\
}}'''
                    for [time, text] in self.text
                ),
                "        ",
            )
        }\\
    ]\\
}}"""


class Option:
    name: str
    flow: list[FlowElement]

    def __init__(self) -> None:
        self.name = None
        self.flow = []

    def __str__(self) -> str:
        if self.name is None:
            raise ErrorMessage("Missing field 'name' in option.")

        return f"""{{\\
    name: {self.name},\\
    flow: [\\
{
            indent(
                ",\\\n".join(f"{e}" for e in self.flow),
                "        ",
            )
        }\\
    ]\\
}}"""


class Choice(FlowElement):
    id: str
    options: list[Option]

    def __init__(self, id):
        self.id = id
        self.options = []

    def __str__(self) -> str:
        return f"""{{\\
    id: "choice",\\
    options: [\\
{
            indent(
                ",\\\n".join(f"{option}" for option in self.options),
                "        ",
            )
        }\\
    ]\\
}}"""


class Dialog:
    participants: dict[str, Participant] = {}
    flow: list[FlowElement] = []

    def __str__(self) -> str:
        return f"""function skys_horizon:dialog/play {{\\
    participants: {{\\
{
            indent(
                ",\\\n".join(f'"{k}": {v}' for k, v in self.participants.items()),
                "        ",
            )
        }\\
    }},\\
    flow: [\\
{
            indent(
                ",\\\n".join(f"{e}" for e in self.flow),
                "        ",
            )
        }\\
    ]\\
}}
"""
