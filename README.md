# Guard::Nanoc

This is a guard for [nanoc](http://nanoc.ws/).

`Guard` is a framework for listening to filesystem changes and acting upon them. `Guard::Nanoc` is a plugin for Guard that recompiles Nanoc sites on changes.

## Installation

Add this line to your application's Gemfile:

    gem 'guard-nanoc'

And then execute:

    $ bundle

## Usage

Enter the nanoc site directory for which you want to use guard-nanoc. Create a Guardfile using `guard init`:

    $ bundle exec guard init nanoc

Execute guard:

    $ bundle exec guard

Whenever you change a file in the Nanoc site directory now, the site will be recompiled!

### Viewing pages

To see the site, run the following:

    $ bundle exec nanoc view

Now you can visit `http://localhost:3000` in browser. (In some cases, the port number might not be `3000`; check what `nanoc view` prints to find out the actual port number.)

For best results, keep both `guard` and `nanoc view` running at the same time, either in separate windows/tabs, or with screen/tmux. 

After edditing and saving a file, `guard` will recompile the site, but it is necessary to reload the page in the browser in order to see the new content that is served by `nanoc view`.
