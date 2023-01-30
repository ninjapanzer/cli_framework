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
    Bundler::Installer.install(
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
loader.eager_load_namespace(Cli::Command)

module Cli
  CONFIG_PATH = File.join(Dir.home, ".cli", "config.yml")

  class Error < StandardError; end
  class Boot < Thor; end

  # Your code goes here...
  ConfigSetup.autosetup(config_path: CONFIG_PATH)
  CONFIG = ConfigLoader.config.freeze

  Cli::Refinements::ThorRegistry::Registry.commands.map do |local_command|
    Sideloader.new(cli_klass: Boot, gem_name: nil, path: nil).register_local_command(local_command_description: local_command)
  end

  CONFIG["commands"].map do |command_options|
    Sideloader.new(cli_klass: Boot, gem_name: command_options["name"], path: command_options["path"]).load
  end
end

Cli::Boot.start(ARGV) if $0 == __FILE__
