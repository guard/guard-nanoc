# encoding: utf-8

require 'guard/compat/plugin'

require 'nanoc'
require 'nanoc/cli'

module Guard

  class Nanoc < Plugin

    def initialize(options={})
      @dir = options[:dir] || '.'
      super
    end

    def start
      self.setup_nanoc_notifications
      self.recompile_in_subprocess
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

    def setup_nanoc_notifications
      @rep_times = {}
      ::Nanoc::NotificationCenter.on(:compilation_started) do |rep|
        @rep_times[rep.raw_path] = Time.now
      end
      ::Nanoc::NotificationCenter.on(:compilation_ended) do |rep|
        @rep_times[rep.raw_path] = Time.now - @rep_times[rep.raw_path]
      end
      ::Nanoc::NotificationCenter.on(:rep_written) do |rep, path, is_created, is_modified|
        action = (is_created ? :create : (is_modified ? :update : :identical))
        level  = (is_created ? :high   : (is_modified ? :high   : :low))
        duration = Time.now - @rep_times[rep.raw_path] if @rep_times[rep.raw_path]
        ::Nanoc::CLI::Logger.instance.file(level, action, path, duration)
      end
    end

    def recompile_in_subprocess
      if Process.respond_to?(:fork)
        pid = Process.fork { self.recompile }
        Process.waitpid(pid)
      else
        self.recompile
      end
    end

    def recompile
      Dir.chdir(@dir) do
        site = ::Nanoc::Site.new('.')
        site.compile
        self.prune(site)
      end
      self.notify_success
    rescue ::Nanoc::Errors::GenericTrivial => e
      self.notify_failure
      $stderr.puts e.message
    rescue RuntimeError => e
      self.notify_failure
      ::Nanoc::CLI::ErrorHandler.print_error(e)
    end

    def prune(site)
      prune_config = site.config.fetch(:prune, {})
      auto_prune_enabled = prune_config.fetch(:auto_prune, false)
      if auto_prune_enabled
        exclude = prune_config.fetch(:exclude, [])
        ::Nanoc::Extra::Pruner.new(site, :exclude => exclude).run
      end
    end

    def notify_success
      Compat::UI.notify('Compilation succeeded', :title => 'nanoc', :image => :success)
      Compat::UI.info 'Compilation succeeded.'
    end

    def notify_failure
      Compat::UI.notify('Compilation FAILED', :title => 'nanoc', :image => :failed)
      Compat::UI.error 'Compilation failed!'
    end

  end

end
