require "yaml"
require "erb"
require "active_record"
include ActiveRecord::Tasks
require "./models.rb"

config= ->(t) do
  root= File.expand_path ".." , __FILE__
  conf= File.join root, "database.yml"
  class SeedLoader
    def initialize(path);@path= path;end
    def load_seed;load @path;end
  end

  t.env = ENV["ENV"] || "development"
  t.database_configuration= YAML.load(ERB.new(File.read(conf)).result)
  t.db_dir=  File.join root, 'db'
  # t.fixtures_path= File.join root, "test/fixtures"
  t.migrations_paths= [File.join(root, "db/migrate")]
  t.seed_loader = SeedLoader.new(File.join root, "db/seeds.rb")
  t.root= root
end
config.(DatabaseTasks)

task :environment do
  ActiveRecord::Base.configurations= DatabaseTasks.database_configuration
  ActiveRecord::Base.default_timezone= :local
  # logfile= File.join(DatabaseTasks.root, "log/db.log")
  # ActiveRecord::Base.logger = Logger.new(logfile)
  ActiveRecord::Base.establish_connection DatabaseTasks.env.to_sym
end

load "active_record/railties/databases.rake"

namespace :app do
  desc "sandbox task"
  task :sandbox => :environment do
    class << Item
      def sample; where( 'id >= ?', rand(first.id..last.id) ).first;end
    end
    puts Item.sample.name
  end
end
