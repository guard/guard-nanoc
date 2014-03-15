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
