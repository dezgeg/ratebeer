class RatingsController < ApplicationController
  before_action :set_beers, only: [:new, :create]

  def index
    @recent_ratings = Rating.recent
    @top_beers = Beer.top_rated(3)
    @top_breweries = Brewery.top_rated(3)
    @top_users = User.top_raters(3)
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    @rating.user = current_user
    if @rating.user && @rating.save
      redirect_to current_user
    else
      render :new
    end
  end

  def destroy
    r = Rating.find(params[:id])
    raise "Can't destroy" if r.user != current_user
    r.destroy
    redirect_to :back
  end

  private
  def set_beers
    @beers = Beer.all
  end
end
