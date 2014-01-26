module RatingAverage
  def average_rating
    ratings.inject(0.0) { |a, r| a + r.score } / ratings.size
  end
end
