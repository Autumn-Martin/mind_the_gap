class Campsite < ApplicationRecord
  has_many :reservations
  validates_presence_of :name
end
