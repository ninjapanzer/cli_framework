# frozen_string_literal: true

require 'yaml'

source "https://rubygems.org"

config_dir = File.join(Dir.home, '.cli')
config_commands = YAML.load_file(File.join(config_dir, 'config.yml'))['commands']
config_commands.map do |command_options|
  case
  when command_options['path'].nil?
    gem command_options['name']
  else
    gem command_options['name'], path: File.join(config_dir, 'commands', command_options['name'])
  end
end

# Specify your gem's dependencies in cli.gemspec
gemspec

gem "rake", "~> 13.0"

gem "rspec", "~> 3.0"

gem "rubocop", "~> 1.21"

gem "cli_toolkit", "~> 0.1.0", path: '../cli_toolkit', require: false
