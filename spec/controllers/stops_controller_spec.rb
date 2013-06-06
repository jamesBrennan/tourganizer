require 'spec_helper'

describe StopsController do

  describe 'index' do
    it 'returns json' do
      get :index, format: :json
      response.should == {}
    end
  end

end
