module Cli::Storage
  def self.db(db:)
    @db ||= setup(db: db)
  end

  def self.setup(db:)
    if File.exist?(db)
      # Open the existing database
      SQLite3::Database.new db
    else
      # Create a new database
      puts "Creating new database"
      connection = SQLite3::Database.new db
      connection.execute("CREATE TABLE versions (id INTEGER PRIMARY KEY, migrated_at DATETIME DEFAULT CURRENT_TIMESTAMP)")
      connection
    end
  end

  def self.requires_migration?
    self.online_migrations < self.migrations.count
  end

  def self.online_migrations
    @online_migrations ||= @db.execute("SELECT count(*) FROM versions")[0][0]
  end
  def self.migrate
    if self.requires_migration?
      self.migrations.slice(self.online_migrations..).each do |sql|
        @db.execute(sql)
        @db.execute("INSERT INTO versions (migrated_at) VALUES (CURRENT_TIMESTAMP)")
      end
    end
  end

  def self.migrations
    [
      "CREATE TABLE answers (id INTEGER PRIMARY KEY, question_id INTEGER, answer TEXT, created_at DATETIME DEFAULT CURRENT_TIMESTAMP)",
    ]
  end
end
