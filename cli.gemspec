# frozen_string_literal: true

require_relative "lib/cli/version"
require 'yaml'

Gem::Specification.new do |spec|
  spec.name = "cli"
  spec.version = Cli::VERSION
  spec.authors = ["Paul Scarrone"]
  spec.email = ["paul@scarrone.co"]

  spec.summary = "Write a short summary, because RubyGems requires one."
  spec.description = "Write a longer description or delete this line."
  spec.homepage = "Put your gem's website or public repo URL here."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.homepage = "https://example.com"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "zeitwerk", "~> 2.6.6"
  spec.add_dependency "thor", "~> 1.2.1"
  spec.add_dependency "sqlite3", "~> 1.4.2"

  # load yaml config from the home directory .cli/config.yml and extract an array of commands
  config_dir = File.join(Dir.home, '.cli')
  config_commands = YAML.load_file(File.join(config_dir, 'config.yml'))['commands']
  config_commands.map do |command_options|
    spec.add_runtime_dependency command_options['name']
  end


  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
