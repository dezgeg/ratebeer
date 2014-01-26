class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def average_rating
    ratings.inject(0.0) { |a, r| a + r.score } / ratings.size
  end
end
