class Reservation < ApplicationRecord
  belongs_to :campsite
  validates_presence_of :start_date, :end_date

  def self.booked_campsites
    ## SQL - OUTER POSSIBILITIES
    # find_by_sql("SELECT reservations.campsite_id FROM reservations INNER JOIN campsites ON campsites.id = reservations.campsite_id WHERE start_date  < '20180608' AND end_date > '20180608'")
    ## ActiveRecord - OUTER POSSIBILITIES
    # select('campsite_id').joins(:campsite).where('start_date < ? AND end_date > ?', '20180608', '20180608').pluck('campsite_id')

    ## ActiveRecord - INNER POSSIBILITIES
    range = Date.strptime('2018-06-07', "%Y-%m-%d")..Date.strptime('2018-06-07', "%Y-%m-%d")
    select('campsite_id').joins(:campsite).where("start_date IN (?) OR end_date IN (?)", range, range).pluck(:campsite_id)

    ## ActiveRecord - BOTH POSSIBILITIES
    range = Date.strptime('2018-06-02', "%Y-%m-%d")..Date.strptime('2018-06-02', "%Y-%m-%d")
    select('campsite_id').joins(:campsite).where('start_date < ? AND end_date > ? OR start_date IN (?) OR end_date IN (?)', '20180602', '20180602', range, range).pluck(:campsite_id)
  end
end
