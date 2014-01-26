class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    ratings.inject(0.0) { |a, r| a + r.score } / ratings.size
  end

  def to_s
    "#{name} (#{brewery.name})"
  end
end
