class Stop < ActiveRecord::Base
  validates_presence_of :date, :location
end
