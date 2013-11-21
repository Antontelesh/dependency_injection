Dependency Injection
====================

Custom Dependency Injection for Javascript Apps

This is a simple tool to manage dependencies in JavaScript files.
Its syntax is a bit like AngularJS's dependency injection syntax.
If you don't want to load RequireJS (or something like it) to your page, you may use this simple script.
Just add it to your page and wrap your modules with its special wrappers (see Syntax section below).
Since now your modules will be executed in proper order no matter what order they have been loaded.
In addition you may reach all your module dependencies in module function arguments.

This allows you to not litter your global scope and to get what you need when you need it.


## Syntax
