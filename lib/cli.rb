# frozen_string_literal: true

require_relative "cli/version"
require "zeitwerk"
require "thor"
require "sqlite3"

loader = Zeitwerk::Loader.for_gem(warn_on_extra_files: false)
loader.setup

module Cli
  CONFIG_PATH = File.join(Dir.home, ".cli", "config.yml")

  class Error < StandardError
  end
  # Your code goes here...
  ConfigSetup.autosetup(config_path: CONFIG_PATH)
  CONFIG = ConfigLoader.config.freeze
  CONFIG['commands'].map do |command_options|
    Sideloader.new(gem_name: command_options['name'], path: command_options['path']).load
  end
end

Cli::Command::Config.start(ARGV)
