module Cli::Refinements
  module ThorRegistry
    Registry ||= Module.new do
      def self.register(commands_klass:, details:)
        @registry ||= []
        @registry << { commands_klass: commands_klass, details: details }
      end

      def self.commands
        @registry
      end
    end

    refine Thor.singleton_class do
      def subcommand(registry: Cli::Refinements::ThorRegistry::Registry, commands_klass:, details: {})
        details[:desc] ||= @desc
        details[:name] ||= @usage
        details[:usage] ||= @usage
        details[:long_desc] ||= @long_desc

        registry.register(commands_klass: commands_klass, details: details)
        super(details[:name], commands_klass)
      end
    end
  end
end
