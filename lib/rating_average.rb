module RatingAverage
  def average_rating
    ratings.empty? ? 0.0 : ratings.inject(0.0) { |a, r| a + r.score } / ratings.size
  end

  def self.included(base)
    base.extend(ClassMethods)
  end
  module ClassMethods
    def top_rated(n)
      self.all.sort_by { |x| -(x.average_rating || 0.0) }[0...n]
    end
  end
end
