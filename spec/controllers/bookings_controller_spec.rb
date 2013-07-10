require 'spec_helper'

describe BookingsController do

  let(:stop) { Fabricate :stop }
  let(:attrs) { Fabricate.attributes_for :booking, stop: nil }
  let(:booking) { Fabricate :booking, stop: stop, status: 'offered' }

  before do
    @stop = Fabricate :stop
  end

  describe 'GET index' do
    render_views

    it 'returns json' do
      booking
      get :index, stop_id: stop.id, format: :json
      bookings = JSON.parse(response.body)['bookings']
      expect(bookings.length).to eq 1
      expect(bookings[0]['id']).to eq booking.id
    end
  end

  describe 'POST create' do
    it 'creates a new booking' do
      expect {
        post :create, stop_id: stop.id, booking: attrs
      }.to change(Booking, :count).from(0).to(1)
    end
  end

  describe 'GET' do
    render_views

    it 'returns the resource' do
      get :show, stop_id: stop.id, id: booking.id
      booking = JSON.parse(response.body)['booking']
      expect(booking).to eq booking
    end
  end

  describe 'DELETE' do
    it 'accepts an id' do
      booking
      expect {
        delete :destroy, stop_id: stop.id, id: booking.id
      }.to change(Booking, :count).from(1).to(0)
    end
  end

end
