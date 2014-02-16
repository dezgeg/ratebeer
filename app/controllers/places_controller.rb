class PlacesController < ApplicationController
  def index
    @places = []
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    render :index
  end
end
