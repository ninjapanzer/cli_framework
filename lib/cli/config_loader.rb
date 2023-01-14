require "yaml"

module Cli::ConfigLoader
  def self.load
    # Load the config file
    @config = YAML.load_file(File.join(Dir.home, ".cli", "config.yml"))
  end

  def self.config
    @config ||= load
  end
end
