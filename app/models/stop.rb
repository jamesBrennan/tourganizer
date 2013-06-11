class Stop < ActiveRecord::Base
  validates_presence_of :date, :location
  attr_accessor :drive
end
