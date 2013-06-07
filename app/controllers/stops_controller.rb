class StopsController < ApplicationController
  respond_to :json

  def index
    @stops = Stop.all
  end

  def create

  end
end
