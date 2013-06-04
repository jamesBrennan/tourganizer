class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.date :date
      t.string :city
      t.string :state
      t.integer :user_id
      t.timestamps
    end
  end
end
