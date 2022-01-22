# Redo

Redo is a command line ToDo application for who loves CLI tools.
It is strongly inspired from [mattn's todo](https://github.com/mattn/todo).

It is developed with [Red](https://www.red-lang.org/) programming language.

Here is the usage:

> To get help type `redo ?`

    Commands:
        no argument    : list todos
        <text>         : add new todo
        <id> -         : delete todo
        <id>           : toggle todo
        <id> <text>    : update todo
        *              : purge todos (delete marked todos)
        ?              : show this help

`<id>` is a number between 1 and 999

ToDo items are simply stored in `redo.cnf` file in the folder where the application executed. So you can have multiple ToDo files.


---


An example use (no need to quote)

First add some to-do items:

    > redo Write README.md
    > redo Add CLI mode
    > redo Add release package to GitHub
    > redo Go to shopping

No arguments to list:

    > redo
    ID      Done?   Text
    001     ❌      Write README.md
    002     ❌      Add CLI mode
    003     ❌      Add release package to GitHub
    004     ❌      Go to shopping

Toggle 1st and 4th items:

    > redo 1
    > redo 4
    ID      Done?   Text
    001     ✅      Write README.md
    002     ❌      Add CLI mode
    003     ❌      Add release package to GitHub
    004     ✅      Go to shopping

Update an item:

    > redo 1 Write README.md file
    ID      Done?   Text
    001     ✅      Write README.md file
    ...

Delete the 4th item:

    > redo 4 -

Purge marked items (this will delete all marked items)

    > redo *
    ID      Done?   Text
    001     ❌      Add CLI mode
    002     ❌      Add release package to GitHub

---

It is very simply yet useful application, there are a bunch of things that can be added. Feel free to contribute.

Here are some ideas:

* Store additional user settings in the `redo.cnf` file (like add to top or bottom etc.)
* Encrypt the config file.
* Use user's profile path for the config file.
* Add item creation date
* Add sorting
