class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    r = Rating.new params.require(:rating).permit(:score, :beer_id)
    r.user = current_user
    r.save!
    redirect_to current_user
  end

  def destroy
    r = Rating.find(params[:id])
    raise "Can't destroy" if r.user != current_user
    r.destroy
    redirect_to :back
  end
end
