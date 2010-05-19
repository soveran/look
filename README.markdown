Look
====

Add a vendor directory to your load path.

Description
-----------

If you want to "specify your project's dependencies in a single
place", check [Dependencies](http://github.com/djanowski/dependencies)
(recommended).

If you want "a way to express and automatically install your project's
Gem dependencies", check [Isolate](http://github.com/jbarnette/isolate).

If you want "the best way to manage your application's dependencies",
check [Bundler](http://github.com/carlhuda/bundler).

There maybe other means to that same goal. Look's goal is way more
modest: it allows you to add to your load path directories that respect
the [Ruby Packaging Standard](http://chneukirchen.github.com/rps/).

Usage
-----

Assuming you have the following project layout:

    $ tree
    |-- my_project.rb
    `-- vendor
        `-- foo-0.0.1
            `-- lib
                `-- foo.rb

You can easily configure your project to require `foo` from
`vendor/foo-0.0.1/lib/foo` with this command:

    $ cat my_project.rb

    require "look"

    Look.at File.dirname(__FILE__)

    puts Foo.inspect

The only argument you need to provide is the directory where you want to
search for the vendor directory.

You can optionally supply a second argument, which is the glob used for
adding directories to your load path:

    Look.at File.dirname(__FILE__), "gems/*/lib"

The second parameter defaults to `vendor/*/lib`. You can run `Look.at`
as many times as needed, so you can have both `/vendor` and `/gems` if
you want.

How to put those libraries inside `vendor` is out of the scope of this
project. One idea is to use the `gem unpack` command, but you are free
to improvise.

Installation
------------

    $ sudo gem install look

License
-------

Copyright (c) 2010 Michel Martens

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
