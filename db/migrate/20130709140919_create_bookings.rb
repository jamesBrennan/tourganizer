class CreateBookings < ActiveRecord::Migration
  def up
    create_table :bookings do |t|
      t.integer :stop_id
      t.string :status
      t.string :venue_name
      t.string :venue_address
      t.json :details
      t.timestamps
    end

    execute 'ALTER TABLE bookings ADD COLUMN start_time time'
    execute 'ALTER TABLE bookings ADD COLUMN end_time time'
  end

  def down
    drop_table :bookings
  end
end
