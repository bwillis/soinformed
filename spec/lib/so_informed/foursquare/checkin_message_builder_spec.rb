require './lib/so_informed/foursquare/checkin_message_builder'

describe SoInformed::Foursquare::CheckinMessageBuilder do
  let(:username) { 'Ben W' }
  let(:venue) { double(:short_url => 'http://4sq.com/wg') }
  let(:location_display) { :text }
  let(:checkin) { double(:'has_shout?' => false, :venue_name => 'Willis Greenhouses', :'has_address?' => true, :address => '1365 Lawrenceville, New Jersey') }
  subject do
    SoInformed::Foursquare::CheckinMessageBuilder.from_checkin(username, checkin, venue, location_display)
  end

  it { should eq 'Ben W is at Willis Greenhouses (1365 Lawrenceville, New Jersey) Reply to comment' }

end