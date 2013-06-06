class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.date :date
      t.string :location
      t.json :venues
      t.timestamps
    end
  end
end
