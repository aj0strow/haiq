require 'sequel'

module Database
  def self.url
    env = ENV.fetch('RACK_ENV', 'development')
    ENV.fetch('DATABASE_URL', "postgres://hiq@localhost/hiq_#{env}")
  end  

  def self.migrate
    system "bin/sequel -m app/migrations #{url}"
  end

  def self.registered(base)
    Sequel.connect(url)
  end
end
