class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :beer_club

  validates_presence_of :user
  validates_presence_of :beer_club
  validates_uniqueness_of :beer_club_id, scope: :user_id, message: "You have already joined this club"
end
