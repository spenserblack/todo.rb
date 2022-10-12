# todo.rb

[![CI](https://github.com/spenserblack/todo.rb/actions/workflows/ci.yml/badge.svg)](https://github.com/spenserblack/todo.rb/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/spenserblack/todo.rb/branch/main/graph/badge.svg?token=OfJG8wqItt)](https://codecov.io/gh/spenserblack/todo.rb)

This is a simple CLI application that manages a todo lists in YAML format in files in
`$HOME/.todo`. It takes the following subcommands:

- `todo do [name] [text...]`
- `todo did [name] [index]`
- `todo list`
- `todo show [name]`

Whenever a value isn't specified in the CLI (name of subcommand, name of todo list, todo text, etc.),
you will be prompted interactively to fill out or select this info.

`todo do` will take the name of a todo list and one or more strings as arguments (like `echo`),
and add a new item to `$HOME/.todo/<name>.yaml`.

`todo did` allows you to complete todo list items.

`todo list` shows all existing todo lists.

`todo show` shows the contents of a todo list.

## Installation

```bash
gem install todo --source "https://rubygems.pkg.github.com/spenserblack"
```
