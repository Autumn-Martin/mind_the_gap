class Campsite < ApplicationRecord
  has_many :reservations
  validates_presence_of :name

  def self.poss_campsites(query_start_date, query_end_date)
    Campsite.where.not(id: Reservation.booked_campsite_ids(query_start_date, query_end_date))
  end

  def self.available_campsite_names(query_start_date, query_end_date, gap_rule)
    available_spots = []
    gap_needed = gap_rule + 1

    Campsite.poss_campsites(query_start_date, query_end_date).each do |campsite|

      if campsite.reservations != []
        campsite_rezo_start_dates = campsite.reservations.pluck(:start_date).flatten
        campsite_rezo_end_dates = campsite.reservations.pluck(:end_date).flatten

        differences = []
        campsite_rezo_start_dates.each { |rezo_date| differences << rezo_date.to_date - query_end_date.to_date }
        campsite_rezo_end_dates.each { |rezo_date| differences << query_start_date.to_date - rezo_date.to_date }

        if differences.none? {|diff| diff.to_i == gap_needed}
          available_spots << campsite
        end
      elsif campsite.reservations = []
        available_spots << campsite
      end
    end

    return available_spots.pluck(:name)
  end
end
