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
        post :create, stop: { date: '02/13/2014', location: 'Arcata, CA' }
      }.to change(Stop, :count).from(0).to(1)
    end

    it 'accepts json for venues' do
      expect {
        post :create, stop: {
          date: '05/16/2014',
          location: 'Arcata, CA',
          venues: {
            'Flop House'=> { owner: 'Jason' },
            '1234 Main' => { capacity: 115 }
          }
        }
      }.to change(Stop, :count).from(0).to(1)
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

  describe 'GET schema' do
    render_views

    before do
      @stop = Stop.create date: Date.strptime('06/10/2013', '%m/%d/%Y'), location: 'Jackson, MI'
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
