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
        site = ::Nanoc::Site.new('.')
        site.compile
      end
      self.notify_success
    rescue ::Nanoc::Errors::GenericTrivial => e
      self.notify_failure
      $stderr.puts e.message
    rescue Exception => e
      self.notify_failure
      ::Nanoc::CLI::ErrorHandler.print_error(e)
    end

    def notify_success
      Notifier.notify('Compilation succeeded', :title => 'nanoc', :image => :success)
      ::Guard::UI.info 'Compilation succeeded.'
    end

    def notify_failure
      Notifier.notify('Compilation FAILED', :title => 'nanoc', :image => :failed)
      ::Guard::UI.error 'Compilation failed!'
    end

  end

end
