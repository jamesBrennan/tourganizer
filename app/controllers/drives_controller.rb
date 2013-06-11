class DrivesController < ApplicationController
  respond_to :json

  def index
    @drives = Drive.all.order(:date)
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

  def drive_params
    params[:drife].delete(:origin)
    params[:drife].delete(:destination)
    params.require(:drife).permit!
  end

end
