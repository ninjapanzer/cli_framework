module Cli::Command::GenerateCli
  class GenerateCliCommands < Thor
    namespace :generate_cli
    desc "new", "Create a new CLI Gem"
    def new
      Cli::Command::GenerateCli::NewCommand.new
    end

    desc "teardown", "teardown a cli project"
    def teardown
      Cli::Command::GenerateCli::TeardownCommand.new
    end
  end
end
