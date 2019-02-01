class Api::V1::AvailableCampsiteRetriever
  def initialize(data)
    @start_date = data[:search][:startDate]
    @end_date = data[:search][:endDate]
    @campsites = data[:campsites]
    @rezos = data[:reservations]
  end

  def update_data
    update_campsites
    update_reservations
  end

  def available_campsites
    update_data # if data is retrieved from an external API endpoint instead, this will update the internal database

    booked_campsite_ids = Reservation.booked_campsites(@start_date, @end_date) #=> [1, 2, 3]
    poss_campsites = Campsite.where.not(id: booked_campsite_ids)
    available_spots = []

    poss_campsites.each do |campsite|
      campsite_rezo_dates = campsite.reservations.pluck(:start_date, :end_date)
      if campsite_rezo_dates.include?(Date.strptime(@start_date, '%Y-%m-%d') - 2) && campsite_rezo_dates.exclude?(Date.strptime(@start_date, '%Y-%m-%d') - 1)
      elsif campsite_rezo_dates.include?(Date.strptime(@end_date, '%Y-%m-%d') + 2) && campsite_rezo_dates.exclude?(Date.strptime(@end_date, '%Y-%m-%d') + 1)
      else
        available_spots << campsite
      end
    end

    return available_spots.pluck(:name)
  end

  private

  def update_campsites
    if @campsites.count > Campsite.all.count
      @campsites.each do |campsite|
        Campsite.find_or_create_by(id: campsite[:id], name: campsite[:name])
      end
    end
  end

  def update_reservations
    if @rezos.count > Reservation.all.count
      @rezos.each do |rezo|
        Reservation.find_or_create_by(campsite_id: rezo[:campsiteId], start_date: rezo[:startDate], end_date: rezo[:endDate])
      end
    end
  end
end
