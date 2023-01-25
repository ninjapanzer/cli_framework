module Cli::Command
  class Commands < Thor
    Cli::Command::Config::Command.register_command
    Cli::Command::GenerateCommand::Command.register_command
    Cli::Command::GenerateCli::Command.register_command
  end
end