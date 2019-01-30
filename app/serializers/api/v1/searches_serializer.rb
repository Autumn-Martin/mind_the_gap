class Api::V1::SearchesSerializer
  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  def search_data
    { search: {"startDate": @start_date, "endDate": @end_date},
      campsites: serialized_campsites,
      reservations: serialized_reservations
    }
  end

  def campsite_names
    # this works
    # unavail_campsites_inside_bounds = Campsite.joins(:reservations).where("start_date IN (?) OR end_date IN (?)", @range, @range).pluck(:campsite_id)
    # avail_id = Campsite.where.not(id: unavail_campsites_inside_bounds).pluck(:id)

    return Reservation.booked_campsites #=> [1, 2, 3]
  end


  private

  def serialized_campsites
    unserialized_campsites.map do |campsite|
      {"id": campsite.id, "name": campsite.name}
    end
  end

  def unserialized_campsites
    Campsite.all
  end

  def serialized_reservations
    unserialized_reservations.map do |reservation|
      { "campsiteId": reservation.campsite_id,
        "startDate": reservation.start_date,
        "endDate": reservation.end_date
      }
    end
  end

  def unserialized_reservations
    Reservation.all
  end
end
