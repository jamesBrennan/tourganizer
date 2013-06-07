class CreateJsonSchemas < ActiveRecord::Migration
  def change
    create_table :json_schemas do |t|
      t.string :name
      t.string :version
      t.json :schema
    end
    add_index :json_schemas, [:name, :version], unique: true
  end
end
