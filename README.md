# Guard::Nanoc

This is a guard for [nanoc](http://nanoc.ws/).

## A note on Rubygems ownership

The RubyGems gem name 'guard-nanoc' is currently taken by an old and now defunct [project](https://github.com/guard/guard-nanoc) - while the author and RubyGems.org are being contacted, you can use Git instead:

### Installing with Git

Add this line to your application's Gemfile:

    gem 'guard-nanoc', :github => 'nanoc/guard-nanoc'

Or, to fetch it manually: 

    $ git clone git://github.com/nanoc/guard-nanoc.git 
    $ cd guard-nanoc 
    $ gem build guard-nanoc.gemspec 
    $ gem install guard-nanoc-*.gem 

then add this line to your application's Gemfile:

    gem 'guard-nanoc', :path => '/path/to/local/gem/guard-nanoc-*'

After setting up the gem either way, run:

    $ bundle

## Usage

Create a Guardfile using `guard init`:

    $ guard init nanoc

Execute guard:

    $ guard
    
N.B. Remember to run `bundle exec guard` if you're using Bundler
