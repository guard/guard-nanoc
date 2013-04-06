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
      self.setup_nanoc_notifications
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

    def setup_nanoc_notifications
      @rep_times = {}

      ::Nanoc::NotificationCenter.on(:compilation_started) do |rep|
        @rep_times[rep.raw_path] = Time.now
      end

      ::Nanoc::NotificationCenter.on(:compilation_ended) do |rep|
        @rep_times[rep.raw_path] = Time.now - @rep_times[rep.raw_path]
      end

      ::Nanoc::NotificationCenter.on(:rep_written) do |rep, path, is_created, is_modified|
        action =  if is_created then 
                    :create
                  else 
                    if is_modified then :update else :identical end
                  end

        level =   if is_created or (not is_created and is_modified) then
                    :high
                  else
                    :low
                  end

        duration = Time.now - @rep_times[rep.raw_path] if @rep_times[rep.raw_path]
        ::Nanoc::CLI::Logger.instance.file(level, action, path, duration)
      end
    end

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
