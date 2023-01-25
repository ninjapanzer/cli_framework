module Cli::Command::GenerateCommand
  class Command
    # namespace :generate_command
    # desc "generate_command", "Setup the configuration file"
    # subcommand "generate_command", GenerateCommandCommands

    def self.register_command
      Thor.register(GenerateCommandCommands, "generate_command", "generate_command", "Setup the configuration file")
    end
  end
end