class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :beer_club

  validates_presence_of :user
  validates_presence_of :beer_club
end
