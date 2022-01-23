Red [
    title:      "ReDo - Command Line ToDo App"
    author:     "Semseddin (Endo64) Moldibi"
    version:    1.0.0
    date:       2022-01-21
    license:    "MIT"
    file:       %redo.red
    home:       https://github.com/endo64/redo
]

;Application context
app: context [
    title: "Command Line ToDo v1.0.0"
    help-text: {Commands:
     no argument    : list todos
     <text>         : add new todo
     <id> -         : delete todo
     <id>           : toggle todo
     <id> <text>    : update todo
     *              : purge todos (delete marked todos)
     ?              : show this help
    }

    todos: []
    todo-file: %redo.todo

    ;Keep overwritten system words
    load*:      :system/words/load
    save*:      :system/words/save
    add*:       :system/words/add
    remove*:    :system/words/remove

    run: function [/local id] [
        ;Charsets & Parse rules
        ws: charset reduce [#" " tab]
        nws: complement ws
        digit: charset [#"0" - #"9"]
        idr: [copy id 1 3 digit]

        ;Parse command line arguments
        parse trim system/script/args [
            end (list)
            |
            "?" (help)
            |
            "*" (purge save list)
            |
            idr some ws "-" (remove load* id save list)
            |
            idr some ws copy text to end (update load* id text save list)
            |
            idr end (toggle load* id save list)
            |
            copy text to end (add text save list)
        ]
    ]
    
    help: does [print [title newline help-text newline]]

    load: function [/extern todos] [
        if exists? todo-file [
            todos: load* todo-file
        ]
    ]

    save: function [] [
        save* todo-file new-line/skip todos on 2
    ]

    list: function [] [
        if empty? todos [print "Nothing To-Do! ✨" exit]
        print ["ID" tab "Done?" tab "Text"]
        i: 1
        foreach [mark text] todos [
            print [pad/with/left i 3 #"0" tab  pick "✘✔" mark + 1  tab text]
            i: i + 1
        ]
    ]

    add: function [text] [
        append todos reduce [0 text]
    ]

    update: function [id text] [
        unless pos: pos? id [exit]
        change next pos text
    ]

    remove: function [id] [
        unless pos: pos? id [exit]
        remove*/part pos 2
    ]

    toggle: function [id] [
        unless pos: pos? id [exit]
        change pos (1 - pos/1)
    ]

    purge: does [
        todos: parse todos [collect [some [keep quote 0 keep string! | skip]]]
    ]

    pos?: function [id] [
        if empty? m: at todos 2 * id - 1 [
            print ["❗ID:" id "not found." newline]
            return none
        ]
        m
    ]
]


;App start

do bind [
    load
    run
] app

