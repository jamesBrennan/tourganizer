class Stop < ActiveRecord::Base
  validates_presence_of :date, :location
  has_many :drives, foreign_key: 'destination_id'
end
