# Dependency Injection

Custom Dependency Injection for Javascript Apps

This is a simple tool to manage dependencies in JavaScript files.
Its syntax is a bit like AngularJS's dependency injection syntax.
If you don't want to load RequireJS (or something like it) to your page, you may use this simple script.
Just add it to your page and wrap your modules with its special wrappers (see Syntax section below).
Since now your modules will be executed in proper order no matter what order they have been loaded.
In addition you may reach all your module dependencies in module function arguments.

This allows you to not litter your global scope and to get what you need when you need it.


## Syntax

This script adds an object [DI] to your global scope so yau may reach it from anywhere.
DI object has one important method: DI.module().
It's responsible for declaring a new module that would be available as a dependency for another one.
Let's look at the syntax of this method:
<code>
  DI.module(module_name:string, [module_dependencies:array | module_function])
</code>.

Module name is required and dependencies are not.
You may pass either a module function to the second argument or an array of dependencies.
In case you pass an array the last array item should be your module function.
This approach is useful for the case you will pass some dependencies later.
So below are some examples of using it.

#### Module with no dependencies
<pre>
  DI.module('My first module', function(){
    // module code comes here
  })
</pre>

or

<pre>
  DI.module('My first module', [function(){
    // module code comes here
  }])
</pre>

#### Module with dependencies
<pre>
  DI.module('My dependent module', ['My independent module', function(independent){
    // dependent module code comes here
  }])
  
  DI.module('My independent module', function(){
    // independent module code comes here
  })
</pre>

In this case the dependent module code will be executed only after executing independent one.
In addition in your dependent code you may reach the result of your independent code.
So for this case be aware to return something in your independent module.

Happy coding!
