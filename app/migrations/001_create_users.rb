Sequel.migration do
  up do
    create_table :users do
      primary_key :id

      String :twitter_id, null: false
      index :twitter_id, unique: true

      String :name, null: false
      String :image, null: false
      Time :created_at
      Time :updated_at
    end
  end

  down do
    drop_table :users
  end
end
