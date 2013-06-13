class Drive < ActiveRecord::Base
  belongs_to :origin, class_name: 'Stop', foreign_key: 'origin_id'
  belongs_to :destination, class_name: 'Stop', foreign_key: 'destination_id'

  validates_associated :origin
  validates_associated :destination
end
