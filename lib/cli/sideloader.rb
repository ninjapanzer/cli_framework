module Cli
  class Sideloader
    attr_reader :gem_name, :path
    def initialize(gem_name:, path:)
      @gem_name = gem_name
      @path = path
    end

    def load
      require gem_name

      Object.const_get("#{to_studly(gem_name)}::Register").()
    rescue NameError => e
      case e.message
      when /uninitialized constant #{to_studly(gem_name)}::Register/
        puts("Sideload configured #{gem_name} is not side loadable, Consider uninstalling it")
      else
        puts("something is wrong with extension \#{gem_name}")
        raise e
      end

    rescue LoadError => e
      puts("#{gem_name} is not found in specified path: #{e}. You might wanna fetch it first.")
    rescue e
      puts("haha")
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
