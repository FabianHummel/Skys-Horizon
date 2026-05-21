function skys_horizon:dialog/play {
    participants: {
        "phoenix": {
            name: {
                text: "Phoenix",
                color: "#FAB100"
            },
            text_color: "#123456"
        },
        "chance": {
            name: {
                text: "Chance",
                color: "#4798f5"
            }
        }
    },
    flow: [
        {
            id: "paragraph",
            participant: "phoenix"
            timeline: [
                {
                    time: 0,
                    text: "simple text",
                    sound: "skys_horizon:dialog.test"
                },
                {
                    time: 50,
                    text: {
                        text: "fancy text",
                        color: "#FFFFFF"
                    },
                    run: "say Hello from dialog!"
                }
            ]
        },
        {
            id: "choice",
            options: [
                {
                    text: "Option 1",
                    flow: [
                        {
                            id: "paragraph",
                            participant: "phoenix"
                            timeline: [
                                {
                                    time: 0,
                                    text: "answer to option 1"
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    ]
}