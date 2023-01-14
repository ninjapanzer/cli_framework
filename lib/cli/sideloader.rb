module Cli
  class Sideloader
    attr_reader :gem_name, :path
    def initialize(gem_name:, path:)
      @gem_name = gem_name
      @path = path
    end

    def load
      if rubygem?
        require gem_name

      else
        begin
          $LOAD_PATH << File.join(Dir.home, ".cli", "commands", gem_name)
          Gem.clear_paths
          require gem_name
          Object.const_get("#{to_studly(gem_name)}::Register").register_commands

        rescue LoadError => e
          puts("#{gem_name} is not found in specified path: #{e}. You might wanna fetch it first.")
        end
      end
    end

    private

    def to_studly(string)
      string.split("_").map(&:capitalize).join
    end
    def rubygem?
      @path.nil?
    end
  end
end
