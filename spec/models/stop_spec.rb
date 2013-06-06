require 'spec_helper'

describe Stop do
  it 'creates' do
    stop = Stop.create date: Date.today(), location: 'New York, NY', venues: {name: 'bowery ballroom'}
    stop.id.should_not be nil
  end
end
