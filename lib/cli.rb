# frozen_string_literal: true
require 'bundler'

begin
  Bundler.setup(:default)
rescue Bundler::BundlerError => e
  # Prompt the user for confirmation
  puts "Looks like some extensions / dependencies are out of date shall I fix that? (y/n)"
  answer = gets.chomp

  if answer == 'y'
    dir = Bundler.default_gemfile.dirname
    gemfile = File.join(dir, 'Gemfile')
    lockfile = File.join(dir, 'Gemfile.lock')
    # Set the path to the Gemfile
    installer = Bundler::Installer.install(
      File.join(dir, 'Gemfile'),
      Bundler::Definition.build(gemfile, lockfile, nil),
      {
        path: File.join(dir, 'vendor'),
        jobs: 4
      }
    )
    puts "Bundle install completed successfully"
  else
    puts "Bundle install skipped"
  end
end

require_relative "cli/version"
require "zeitwerk"
require "thor"
require "sqlite3"

loader = Zeitwerk::Loader.for_gem(warn_on_extra_files: false)
loader.setup

module Cli
  CONFIG_PATH = File.join(Dir.home, ".cli", "config.yml")

  class Error < StandardError; end

  class Start < Thor;
    namespace :config
    desc "config", "Setup the configuration file"
    subcommand "config", Command::Config::ConfigCommands
  end

  # Your code goes here...
  ConfigSetup.autosetup(config_path: CONFIG_PATH)
  CONFIG = ConfigLoader.config.freeze
  CONFIG["commands"].map do |command_options|
    Sideloader.new(cli_klass: Start, gem_name: command_options["name"], path: command_options["path"]).load
  end
end

Cli::Start.start(ARGV) if $0 == __FILE__
