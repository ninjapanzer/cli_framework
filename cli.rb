require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.push_dir("#{__dir__}", namespace: Cli)
loader.setup

Cli::Survey.new
