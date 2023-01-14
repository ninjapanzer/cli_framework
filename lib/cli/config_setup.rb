module Cli::ConfigSetup
  def self.autosetup(config_path: File.join(Dir.home, ".cli", "config.yml"))
    # Check if the config file exists
    return if File.exist?(config_path)

    # Create the config file
    FileUtils.mkdir_p(File.dirname(config_path))
    FileUtils.cp(File.join(__dir__, "../../config/config.yml"), config_path)
  end
end
