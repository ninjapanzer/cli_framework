# A Thor command which can be used to configure the CLI.
# It will be able to "setup" and "reset" the configuration
# Configuration file will be in the user's home directory
# in a hidden folder called ".cli" and will be called "config.yml"

module Cli::Command::Config
  class Command < Thor
    namespace :config
    desc "config", "Setup the configuration file"
    subcommand "config", ConfigCommands
  end
end
