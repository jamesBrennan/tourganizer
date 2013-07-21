require 'spec_helper'

describe StopsController do

  describe 'GET index' do
    render_views

    it 'returns json' do
      get :index, format: :json
      JSON.parse(response.body).should == []
    end
  end

  describe 'POST create' do
    it 'creates a new stop' do
      expect {
        post :create, stop: { date: '2013-06-20T07:00:00.000Z', location: 'Arcata, CA' }
      }.to change(Stop, :count).from(0).to(1)
    end

    it 'accepts json for venues' do
      expect {
        post :create, stop: {
          date: '2013-06-20',
          location: 'Arcata, CA',
          venues: {
            'Flop House'=> { owner: 'Jason' },
            '1234 Main' => { capacity: 115 }
          }
        }
      }.to change(Stop, :count).from(0).to(1)
    end

    it 'saves bookings' do
      expect {
        post :create, stop: {
          date: '2013-06-20',
          location: 'Arcata, CA',
          venues: {
            'Flop House'=> { owner: 'Jason' },
            '1234 Main' => { capacity: 115 }
          }},
          bookings: [{
            start_time: '20:00:00',
            status: 'offered',
            venue_name: 'The Castle',
            venue_address: '123 fairyland lane'
          }]
      }.to change(Booking, :count).from(0).to(1)
    end
  end

  describe 'GET new' do
    before do
      JsonSchema.create name: 'stop', version: '0.1.0', schema: '{"name": "my schema"}'
    end
    it 'returns a json_schema' do
      get :schema
      response.body.should == '{"name":"my schema"}'
    end
  end

  describe 'GET' do
    render_views

    before do
      @stop = Stop.create date: Date.parse('2013-06-20T07:00:00.000Z'), location: 'Jackson, MI'
    end

    it 'returns the resource' do
      get :show, id: @stop.id
      JSON.parse(response.body).should == {
        "id"=>@stop.id,
        "date"=>"2013-06-20",
        "location"=>"Jackson, MI",
        "venues"=>nil,
        "drives"=>[],
        "bookings"=>[]
      }
    end
  end

  describe 'DELETE' do
    before do
      @stop = Stop.create date: Date.parse('2013-06-20T07:00:00.000Z'), location: 'Jackson, MI'
    end

    it 'accepts an id' do
      expect {
        delete :destroy, id: @stop.id
      }.to change(Stop, :count).from(1).to(0)
    end
  end

end
