class User < Sequel::Model
  plugin :timestamps
  one_to_many :haikus

  def as_json(options = {})
    values.slice(:id, :name, :image)
  end
end
