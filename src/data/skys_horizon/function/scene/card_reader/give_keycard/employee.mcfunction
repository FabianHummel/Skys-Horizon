$function skys_horizon:scene/card_reader/give_keycard {\
    name: "AFI Employee Keycard",\
    keys: ["category:employee", "name:$(name)", "room:$(room)"],\
    text: [{text: "Owner: ", italic: false}, {text: "$(name)", italic: true, color: dark_green}]\
}
