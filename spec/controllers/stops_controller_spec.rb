require 'spec_helper'

describe StopsController do

  describe 'GET index' do
    render_views

    it 'returns json' do
      get :index, format: :json
      JSON.parse(response.body).should == {"stops" => []}
    end
  end

  describe 'POST create' do
    it 'creates a new stop' do
      expect {
        post :create, stop: { date: 'Sat Jun 08 2013 00:00:00 GMT-0700 (PDT)', location: 'Arcata, CA' }
      }.to change(Stop, :count).from(0).to(1)
    end

    it 'accepts json for venues' do
      expect {
        post :create, stop: {
          date: 'Sat Jun 08 2013 00:00:00 GMT-0700 (PDT)',
          location: 'Arcata, CA',
          venues: [
            { name: 'Flop House', owner: 'Jason' },
            { name: '1234 Main', capacity: 115 }
          ]
        }
      }.to change(Stop, :count).from(0).to(1)
    end
  end

  describe 'GET new' do
    before do
      JsonSchema.create name: 'stop', version: '0.1.0', schema: '{"name": "my schema"}'
    end
    it 'returns a json_schema' do
      get :new
      response.body.should == '{"name":"my schema"}'
    end
  end

  describe 'GET show' do
    render_views

    before do
      @stop = Stop.create date: (Date.today() + 3.days), location: 'Jackson, MI'
    end

    it 'returns the resource' do
      get :show, id: @stop.id
      JSON.parse(response.body).should == {
        "date"=>"2013-06-10",
        "location"=>"Jackson, MI",
        "venues"=>nil
      }
    end
  end

end
