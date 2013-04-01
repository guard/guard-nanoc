# encoding: utf-8

require 'guard'
require 'guard/guard'

require 'nanoc'
require 'nanoc/cli'

module Guard

  class Nanoc < Guard

    def initialize(watchers=[], options={})
      @dir = options[:dir] || '.'
      super
    end

    def start
      self.recompile
    end

    def run_all
      self.recompile
    end

    def run_on_changes(paths)
      self.recompile
    end

    def run_on_removals(paths)
      self.recompile
    end

  protected

    def recompile
      Dir.chdir(@dir) do
        site = ::Nanoc::Site.new(@dir)
        site.compile
      end
      ::Guard::UI.info 'Compilation succeeded.'
    rescue ::Nanoc::Errors::GenericTrivial => e
      ::Guard::UI.error 'Compilation failed! ' + e.message
    rescue Exception => e
      ::Guard::UI.error 'Compilation failed!'
      ::Nanoc::CLI::ErrorHandler.print_error(e)
    end

  end

end
