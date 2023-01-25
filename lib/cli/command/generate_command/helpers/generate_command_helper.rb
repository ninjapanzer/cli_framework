module Cli::Command::GenerateCommand::Helpers::GenerateCommandHelper
  refine String do
    def to_studly
      split("_").map(&:capitalize).join
    end

    def to_syntax
      gsub(/_/, '-')
    end

    def to_namespace
      gsub(/-/, '_')
    end
  end
end