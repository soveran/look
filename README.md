Look
====

Add directories to and look up files from the load path.


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

### Look.at

To add a directory to Ruby's $LOAD_PATH, pass the path to `Look.at()`.

  Look.at File.dirname(__FILE__) + '/lib'

The +at+ method will join all arguments passed to it, so the above
example can also be written:

  Look.at File.dirname(__FILE__), 'lib'

The +at+ method can also take glob patterns. With this a whole set of 
directories can be added in one step. For example,

    Look.at File.dirname(__FILE__), "vendor/*/lib"

You can run `Look.at` as many times as needed, so you can have both
`/vendor` and `/gems` if you want.

### Look.at_vendor

The following project layout is not uncommon:

    $ tree
    |-- my_project.rb
    `-- vendor
        `-- foo-0.0.1
            `-- lib
                `-- foo.rb

You can easily configure your project to require `foo` from
`vendor/foo-0.0.1/lib/foo` with this:

    $ cat my_project.rb

    require "look"

    Look.at_vendor File.dirname(__FILE__)

The only argument you need to provide is the directory where you want to
search for the vendor directory.

The +at_vendor+ method is a specail case of +at+. It is equivalent to:

    Look.at File.dirname(__FILE__), "vendor/*/lib"

How to put those libraries inside `vendor` is out of the scope of this
project. One idea is to use the `gem unpack` command, but you are free
to improvise.

### Look.up

Look#up allows you to find "plugins" from the standard $LOAD_PATH and across
other library managers if they are in use (namely RubyGems and Roller).
For example, RDoc allows any project to define a 'rdoc/discover.rb' which
will be automatically loaded upon invocation of `rdoc`. If RDoc were to
use Look to find these files the command would be as simple as:

    files = Look.up('rdoc/discover.rb')

`Look.up` allows you to search any location within the load system,
but conventionally it is adventagrous to use a standardized location
for plusgin. That's where `Look.up_plugins` comes in.

### Look.up_plugins

`Look.up` is a general search, where as `Look.up_plugins` searches within
a standardized `plugins` directory.

Using this convention, plugins are expected to be within a library's designated
loadpath(s) under a <tt>plugins/</tt> subdirectory. By using this assigned
space plugins are kept isolated from normal library scripts, which helps
prevent inadvertent name clashes.

For example, lets say we want to create a pluggable template system for our
"luckyweb" project. The <tt>lib/</tt> directory would have the usual
<tt>luckyweb</tt> directory to house the code, but also a
<code>plugins/luckyweb/</code> path in which the plugin templates would
be stored.

Usage is very simple. Just supply a glob to the +Look.up_plugins+ function.

    templates = Look.up_plugins('luckyweb/*')


### A Note on RubyGems

A way has not yet been devised to isolate the actived version of a gem
from the latest inactive version. Therefore some overlap can occur if
an older version of a plugin-containing gem has been activated prior to
calling +Look.up()+. Such an occurance will be rare (considering the use
cases of plugins), so it is nothing to be overly concerned about. Moreover,
it is still a long-way from the offical Gems plugin policy which is 
to find all matching files from *all* versions using +Gem.find_files()+.
I quote Eric Hodel, "It's an encouragement to make your plugin files as
light as possible, such as requiring an additional file or calling some
very stable API." While an understandable encouragment, ultimately it is
not a robust solution.


Installation
------------

    $ sudo gem install look


License
-------

Copyright (c) 2010 Michel Martens & Thomas Sawyer

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
