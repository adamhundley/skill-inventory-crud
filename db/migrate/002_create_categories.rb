require 'sequel'

environments = ["test", "development"]

environments.each do |env|
  database = Sequel.sqlite("db/skill_inventory_#{env}.sqlite3")

  database.create_table(:categories) do
    primary_key :id
    String :category_name
  end
  database.add_column :skills, :category_id, :integer
end
