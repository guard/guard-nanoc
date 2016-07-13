require 'nanoc'

Nanoc::CLI.after_setup do
  live_command_path =
    File.join(File.dirname(__FILE__), 'nanoc', 'cli', 'commands', 'live.rb')
  Nanoc::CLI.add_command(Nanoc::CLI.load_command_at(live_command_path))
end
