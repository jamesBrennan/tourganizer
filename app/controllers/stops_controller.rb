class StopsController < ApplicationController
  respond_to :json
  before_filter :stringify_json_params, only: [:create, :update]

  def index
    @stops = Stop.all.order(:date)
  end

  def create
    @stop = Stop.create(jsonify_string_params stop_params)
    if @stop.id
      render :show
    else
      render :edit
    end
  end

  def update
    @stop = Stop.find(params[:id])
    @stop.update_attributes(jsonify_string_params stop_params)
    render :edit
  end

  def show
    @stop = Stop.find(params[:id])
  end

  def edit
    @stop = Stop.find(params[:id])
  end

  def new
    @stop = Stop.new()
    @stop.venues = {venues: []}
    render :edit
  end

  def schema
    render json: JsonSchema.find_by_name_and_version('stop', '0.1.0').schema, layout: false
  end

  def destroy
    Stop.find(params[:id]).destroy
    head :ok
  end

  private

  def stringify_json_params
    stop = params[:stop]
    bookings = params[:bookings]
    stop[:venues] = stop[:venues].to_json if stop[:venues]
    if bookings
      stop[:bookings_attributes] = bookings
      stop[:bookings_attributes].each_with_index do |booking_attrs, i|
        if stop[:bookings_attributes][i][:details]
          stop[:bookings_attributes][i][:details] = stop[:bookings_attributes][i][:details].to_json
        end
      end
    end
    stop
  end

  def jsonify_string_params(params)
    params[:venues] = JSON.parse(params[:venues]) if params[:venues]
    if params[:bookings_attributes]
      params[:bookings_attributes].each_with_index do |booking_attrs, i|
        if params[:bookings_attributes][i][:details]
          params[:bookings_attributes][i][:details] = JSON.parse(params[:bookings_attributes][i][:details])
        end
      end
    end
    params
  end

  def stop_params
    params.require(:stop).permit(:date, :location, :venues, bookings_attributes: [
      :id, :stop_id, :start_time, :end_time, :status, :venue_name, :venue_address, :details
    ])
  end

end
