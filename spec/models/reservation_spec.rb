require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it {should validate_presence_of :start_date}
  it {should validate_presence_of :end_date}
  it {should belong_to :campsite}
end
