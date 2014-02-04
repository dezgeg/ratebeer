class User < ActiveRecord::Base
  include RatingAverage
  has_secure_password

  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
  validate :password_must_be_complex

  def password_must_be_complex
    unless password and password.length >= 4 and [/[A-Z]/, /[0-9]/].all? { |r| password =~ r }
      errors.add :password, "must be complex"
    end
  end

  has_many :ratings, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
end
