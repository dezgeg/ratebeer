class PlacesController < ApplicationController
  def index
    @city = nil
    @places = []
  end

  def show
    @place = BeermappingApi.places_in(params[:city])[params[:index].to_i]
  end

  def search
    @city = params[:city]
    @places = BeermappingApi.places_in(params[:city])
    render :index
  end
end
