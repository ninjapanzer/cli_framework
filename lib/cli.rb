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
    exit 0
  else
    puts "Bundle install skipped"
  end
end

require_relative "cli/version"
require "zeitwerk"
require "thor"
require "sqlite3"
require 'cli/toolkit/refinements'
require 'cli/toolkit/sideloader'


loader = Zeitwerk::Loader.for_gem(warn_on_extra_files: false)
loader.setup

module Cli
  CONFIG_PATH = File.join(Dir.home, ".cli", "config.yml")

  class Error < StandardError; end
  class Boot < Thor; end

  ConfigSetup.autosetup(config_path: CONFIG_PATH)
  CONFIG = ConfigLoader.config.freeze

  # Your code goes here...
  def self.sideload
    CliToolkit::Registry.reset!.map do |local_command|
      CliToolkit::Sideloader.load_command(cli_klass: Boot).register_commands(command_description: local_command)
    end

    CONFIG["commands"].map do |command_options|
      CliToolkit::Sideloader.import_gem_commands(cli_klass: Boot, gem_name: command_options["name"], path: command_options["path"])
                            .load_command_gem
    end
  end
end

loader.eager_load_namespace(Cli::Command)
Cli.sideload

# puts CliToolkit::Registry.commands.map { |command| command[:details][:name]}.inspect

Cli::Boot.start(ARGV) if $0 == __FILE__
