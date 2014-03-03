namespace :db do
  def env
    ENV.fetch('RACK_ENV', 'development')
  end

  def database
    "hiq_#{env}"
  end

  desc 'create postgres database'
  task :create do
    system "createdb -E UTF8 -w -O hiq #{database}"
  end

  desc 'drop postgres database'
  task :drop do
    system "dropdb #{database}"
  end

  desc 'migrate postgres database'
  task :migrate do
    require './app/helpers/database'
    print 'migrating database... '
    Database.migrate
    puts 'complete!'
  end
end
