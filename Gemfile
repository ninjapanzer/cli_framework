# frozen_string_literal: true

require 'yaml'

source "https://rubygems.org"

config_dir = File.join(Dir.home, '.cli')
yml_location = File.join(config_dir, 'config.yml')
if File.exist?(yml_location)
  config_commands = YAML.load_file(yml_location)['commands']
  config_commands.map do |command_options|
    # puts command_options.inspect
    case
    when command_options['path']
      path = File.join(config_dir, 'commands', command_options['name'])
      # puts path
      gem command_options['name'], path: path
    when command_options['path_relative']
      path = File.join(Dir.pwd, command_options['name'])
      # puts path
      gem command_options['name'], path: path
    else
      gem command_options['name']
    end
  end
else
  puts "config not found skipping"
end

# Specify your gem's dependencies in cli.gemspec
gemspec

gem "rake", "~> 13.0"

gem "rspec", "~> 3.0"

gem "rubocop", "~> 1.21"

gem "cli_toolkit", "~> 0.1.0", path: '../cli_toolkit', require: false
