# A Thor command which can be used to configure the CLI.
# It will be able to "setup" and "reset" the configuration
# Configuration file will be in the user's home directory
# in a hidden folder called ".cli" and will be called "config.yml"

module Cli::Command
  class Config < Thor
    namespace :config

    class SubCommands < Thor
      namespace ':config:subcommands'
      desc "setup", "Setup the configuration file"
      def setup
        Cli::ConfigSetup.autosetup
      end

      desc "reset", "Reset the configuration file"
      def reset
        FileUtils.rm(File.join(Dir.home, ".cli", "config.yml"))
        Cli::ConfigSetup.autosetup
      end
    end
  end
  Thor.desc "config SUBCOMMAND", "Setup the configuration file"
  Thor.subcommand "config", Config::SubCommands
end
