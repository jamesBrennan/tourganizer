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
end
