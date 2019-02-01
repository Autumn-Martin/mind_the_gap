class Reservation < ApplicationRecord
  belongs_to :campsite
  validates_presence_of :start_date, :end_date

  def self.booked_campsite_ids(query_start_date, query_end_date)
    range = Date.strptime(query_start_date, "%Y-%m-%d")..Date.strptime(query_end_date, "%Y-%m-%d")
    numbers_only_start_date = query_start_date.gsub(/[-.\/]/, '')
    numbers_only_end_date = query_start_date.gsub(/[-.\/]/, '')

    select('campsite_id').joins(:campsite).where('start_date < ? AND end_date > ? OR start_date IN (?) OR end_date IN (?)', numbers_only_start_date, numbers_only_end_date, range, range).pluck(:campsite_id)
  end

end
