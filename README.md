# todo.rb

This is a simple CLI application that manages a `.todo.yaml` file in your home
directory. There are two subcommands:

1. `todo do`
2. `todo did`

`todo do` will take one or more strings as arguments (like `echo`) and add a new item
to `.todo.rb.yaml` with a datetime of when it was added.

`todo did` allows you to complete todo list items. It will prompt you to
select one or more items to complete. Items are completed by simply being removed.
