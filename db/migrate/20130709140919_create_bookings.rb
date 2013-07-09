class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :stop_id
      t.datetime :time
      t.string :status
      t.json :details
      t.timestamps
    end
  end
end
