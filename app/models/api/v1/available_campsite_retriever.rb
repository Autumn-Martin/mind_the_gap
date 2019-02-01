class Api::V1::AvailableCampsiteRetriever
  def initialize(data, gap_rule)
    @start_date = data[:search][:startDate]
    @end_date = data[:search][:endDate]
    @campsites = data[:campsites]
    @rezos = data[:reservations]
    @gap_rule = gap_rule.to_i ||= 1
  end

  def update_data
    update_campsites
    update_reservations
  end

  def updated_available_campsites
    update_data # if data is retrieved from an external API endpoint instead, this will update the internal database

    Campsite.available_campsite_names(@start_date, @end_date, @gap_rule)
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
