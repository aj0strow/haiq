Sequel.migration do
  up do
    create_table :haikus do
      primary_key :id
      Integer :user_id, null: false
      String :first, null: false
      String :second, null: false
      String :third, null: false
      Time :created_at
      Time :updated_at
    end
  end

  down do
    drop_table :haikus
  end
end
