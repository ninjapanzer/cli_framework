require 'yaml'
module Cli::ConfigLoader
  def self.load
    # Load the config file
    @config = YAML.load_file("#{__dir__}/../../config/config.yml")
  end

  def self.config
    @config ||= load
  end
end