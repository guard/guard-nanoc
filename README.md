# Guard::Nanoc

This is a guard for [nanoc](http://nanoc.ws/).

Guard is a framework for listening to filesystem changes and acting upon them. Guard::Nanoc is a plugin for Guard that recompiles nanoc sites on changes.

## Installation

Add this line to your application's Gemfile:

    gem 'guard-nanoc'

And then execute:

    $ bundle

## Usage

Enter the nanoc site directory for which you want to use Guard::Nanoc. Create a Guardfile using `guard init`:

    $ bundle exec guard init nanoc

Execute guard:

    $ bundle exec guard

Whenever you change a file in the nanoc site directory now, the site will be recompiled!

### Viewing pages

To see the site:

    $ bundle exec nanoc view

And visit `localhost:3000` in browser, in rare cases `3000` might be a higher number, it is displayed after running `nanoc view` on the end of the message as `port=3000`.

For best results keep both `guard` and `nanoc view` running at the same time (in separate shell windows/tabs). 

After edditing and saving a file `guard` will recompile required pages, it is required to reload the page in browser so the new content can be served by `nanoc view`.
