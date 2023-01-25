module Cli::Command::GenerateCli
  class Command
    # namespace :generate_cli
    # desc "generate_cli", "Setup the configuration file"
    # subcommand "generate_cli", GenerateCliCommands

    def self.register_command
      Thor.register(GenerateCliCommands, "generate_cli", "generate_cli", "Setup the configuration file")
    end
  end
end