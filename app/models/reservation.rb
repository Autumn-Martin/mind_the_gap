class Reservation < ApplicationRecord
  belongs_to :campsite
  validates_presence_of :start_date, :end_date
end
