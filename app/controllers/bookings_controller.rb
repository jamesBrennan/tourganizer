class BookingsController < ApplicationController
  respond_to :json

  def index
    @bookings = Booking.all.order(:start_time)
  end

  def create
    @booking = Booking.create(booking_params)
    if @booking.id
      render :show
    else
      render :edit
    end
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update_attributes(booking_params)
    render :edit
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new()
    @booking.venues = {venues: []}
    render :edit
  end

  def schema
    render json: JsonSchema.find_by_name_and_version('booking', '0.1.0').schema, layout: false
  end

  def destroy
    Booking.find(params[:id]).destroy
    head :ok
  end

  private

  def booking_params
    params.require(:booking).permit!
  end

end
