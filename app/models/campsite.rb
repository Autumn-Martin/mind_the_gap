class Campsite < ApplicationRecord
  has_many :reservations
  validates_presence_of :name

  def self.poss_campsites(query_start_date, query_end_date)
    Campsite.where.not(id: Reservation.booked_campsite_ids(query_start_date, query_end_date))
  end

  def self.available_campsite_names(query_start_date, query_end_date)
    available_spots = []

    Campsite.poss_campsites(query_start_date, query_end_date).each do |campsite|
      campsite_rezo_dates = campsite.reservations.pluck(:start_date, :end_date)

      if campsite_rezo_dates.include?(Date.strptime(query_start_date, '%Y-%m-%d') - 2) && campsite_rezo_dates.exclude?(Date.strptime(query_start_date, '%Y-%m-%d') - 1)
      elsif campsite_rezo_dates.include?(Date.strptime(query_end_date, '%Y-%m-%d') + 2) && campsite_rezo_dates.exclude?(Date.strptime(query_end_date, '%Y-%m-%d') + 1)
      else
        available_spots << campsite
      end
    end

    return available_spots.pluck(:name)
  end
end
