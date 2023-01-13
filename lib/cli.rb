# frozen_string_literal: true

require_relative "cli/version"
require "zeitwerk"
require 'thor'
require 'sqlite3'

loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/cli.rb")
loader.setup

module Cli
  CONFIG = Cli::ConfigLoader.config.freeze
  class Error < StandardError; end
  # Your code goes here...
end

loader.eager_load_dir("#{__dir__}/cli/command")

puts Cli::CONFIG
