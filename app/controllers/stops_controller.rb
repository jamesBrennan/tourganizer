class StopsController < ApplicationController
  respond_to :json

  def index
    @stops = Stop.all.order(:date)
    @stops.each do |stop|
      stop.drive = Drive.find_by_destination_id(stop.id)
    end
  end

  def create
    @stop = Stop.create(stop_params)
    if @stop.id
      render :show
    else
      render :edit
    end
  end

  def update
    @stop = Stop.find(params[:id])
    @stop.update_attributes(stop_params)
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

  def stop_params
    params.require(:stop).permit!
  end

end
