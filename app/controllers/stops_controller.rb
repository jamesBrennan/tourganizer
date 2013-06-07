class StopsController < ApplicationController
  respond_to :json

  def index
    @stops = Stop.all
  end

  def create
    date_from_string = Date.strptime(params[:stop][:date], '%m/%d/%Y')
    @stop = Stop.create(stop_params.merge({date: date_from_string}))
    if @stop.id
      render :show
    else
      render :edit
    end
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

  private

  def stop_params
    params.require(:stop).permit!
  end

end
