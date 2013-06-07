# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

stop_schema = File.read("#{Rails.root}/db/json_schemas/stop.json")
JsonSchema.create name: 'stop', version: '0.1.0', schema: stop_schema
