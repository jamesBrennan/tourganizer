class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :state
      t.text :notes
      t.integer :stop_id
      t.timestamps
    end
    add_column(:bookings, :venue, :json)
  end
end
