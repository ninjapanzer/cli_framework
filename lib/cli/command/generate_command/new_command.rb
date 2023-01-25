module Cli::Command::GenerateCommand
  include Thor::Actions

  class NewCommand
    using Cli::Command::GenerateCommand::Helpers::GenerateCommandHelper

    # Method that shows the directory of the gem
    def show_dir
      puts "Current directory: #{Dir.pwd}"
    end

    def run
      root = Dir.pwd
      template_dir = File.join(root, 'templates', 'command')
      template File.join(template_dir, 'command.rb.tt'), "lib/cli/command/generate_command/new_command.rb"
    end
  end
end