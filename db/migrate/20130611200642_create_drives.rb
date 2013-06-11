class CreateDrives < ActiveRecord::Migration
  def change
    create_table :drives do |t|
      t.integer :origin_id
      t.integer :destination_id
      t.json :distance_matrix
      t.timestamps
    end
  end
end
