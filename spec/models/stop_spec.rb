require 'spec_helper'

describe Stop do
  it 'creates' do
    stop = Stop.create(
      date: Date.strptime('06/27/2013', '%m/%d/%Y'),
      location: 'New York, NY',
      venues: {'bowery ballroom' => {address: 'bowery ballroom'}}
    )
    stop.id.should_not be nil
  end

  it 'accepts array for venues' do
    params = {
      date: Date.strptime('06/27/2013', '%m/%d/%Y'),
      location: 'San Francisco, CA',
      venues: {
        'My House' => { address: '123 Capp Street' }
      }
    }
    stop = Stop.create params
    stop.id.should_not be nil
    stop.date.should == Date.strptime('06/27/2013', '%m/%d/%Y')
  end

  it 'accepts nested attributes for bookings' do
    params = {
      date: Date.strptime('06/27/2013', '%m/%d/%Y'),
      location: 'San Francisco, CA',
      bookings_attributes: [{
        start_time: '20:00:00',
        status: 'offered',
        venue_name: 'The Castle',
        venue_address: '123 fairyland lane'
      }]
    }
    expect {
      Stop.create params
    }.to change(Booking, :count).from(0).to(1)
  end
end
