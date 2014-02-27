class User < Sequel::Model
  plugin :timestamps
  one_to_many :haikus
end
