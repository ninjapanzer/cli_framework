module Cli::Command
  # Create a thor command called Survey
  # The Survey command will read a YAML file and ask the user questions
  # The Answers will be stored in a sqlite database
  class Survey < Thor
    desc "survey", "Start the survey"
    def survey
      db = Cli::Storage.db(db: Cli::CONFIG['surveyDb'])
      puts db.inspect
      # Start the survey
      puts Cli::Storage.online_migrations
      Cli::Storage.migrate if Cli::Storage.requires_migration?
    end

    start
  end
end