module Cli::Command::GenerateCommand
  class GenerateCommandCommands < Thor
    namespace :generate_command
    desc "new", "Create a new CLI Gem"
    def new
      Cli::Command::GenerateCommand::NewCommand.new.show_dir
    end

    desc "teardown", "teardown a cli project"
    def teardown
      Cli::Command::GenerateCommand::TeardownCommand.new
    end

    desc "add_action", "add an action to a command"
    def add_action(command_name)
      Cli::Command::GenerateCommand::AddActionCommand.new(
        command_dir: File.dirname(__FILE__)
      )
    end
  end
end
