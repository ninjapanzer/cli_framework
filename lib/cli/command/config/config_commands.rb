module Cli::Command::Config
  class ConfigCommands < Thor
    namespace :config
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
