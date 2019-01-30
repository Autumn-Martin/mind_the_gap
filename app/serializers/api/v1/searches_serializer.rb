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
    # Reservation.booked_campsites #=> [1, 2, 3]

    ## poss_campsites = campsites that would not be double booked by query time range (poss available)
    ## for each possible campsite
    ##    need difference between query range and next closest rezo range (before & after query range)
    ##    if difference == even
    ##      gap free!
    ##    elsif difference == odd
    ##      gap beware!
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
