# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130709140919) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: true do |t|
    t.integer  "stop_id"
    t.string   "status"
    t.string   "venue_name"
    t.string   "venue_address"
    t.json     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "start_time"
    t.time     "end_time"
  end

  create_table "drives", force: true do |t|
    t.integer  "origin_id"
    t.integer  "destination_id"
    t.json     "distance_matrix"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "json_schemas", force: true do |t|
    t.string "name"
    t.string "version"
    t.json   "schema"
  end

  add_index "json_schemas", ["name", "version"], name: "index_json_schemas_on_name_and_version", unique: true, using: :btree

  create_table "stops", force: true do |t|
    t.date     "date"
    t.string   "location"
    t.json     "venues"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tour_id"
  end

  create_table "tours", force: true do |t|
    t.string   "name"
    t.string   "artist"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
