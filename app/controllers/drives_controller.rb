class DrivesController < ApplicationController
  respond_to :json

  def index
    @drives = Drive.where(query_params).includes(:origin, :destination)
  end

  def create
    if @drive = Drive.find_by_origin_id_and_destination_id(drive_params[:origin_id], drive_params[:destination_id])
      render :show
      return
    end
    @drive = Drive.create(drive_params)
    if @drive.id
      render :show
    else
      render :edit
    end
  end

  def update
    @drive = Drive.find(params[:id])
    @drive.update_attributes(drive_params)
    render :edit
  end

  def show
    @drive = Drive.find(params[:id])
  end

  def edit
    @drive = Drive.find(params[:id])
  end

  def new
    @drive = Drive.new()
    render :edit
  end

  def destroy
    Drive.find(params[:id]).destroy
    head :ok
  end

  private

  def query_params
    keys = %w(origin_id destination_id) & params.keys
    return [] unless keys.length > 0
    out = {}
    keys.each {|key| out[key] = params[key]}
    out
  end

  def drive_params
    params[:drive].delete(:origin)
    params[:drive].delete(:destination)
    params.require(:drive).permit!
  end

end
