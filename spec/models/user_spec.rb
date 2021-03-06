require 'spec_helper'

describe User do
  it "has the username set correctly" do
    user = User.new username: "Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user) { User.create username: "Pekka", password: "Secret1", password_confirmation: "Secret1" }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      rating = Rating.new score: 10
      rating2 = Rating.new score: 20

      user.ratings << rating
      user.ratings << rating2

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  password_tests = {
    'abcdefgh' => 'no numbers',
    'aA1' => 'too short',
  }

  password_tests.each do |pass, reason|
    describe "with an improper password '#{pass}' (#{reason})" do
      let(:user) { User.create username: "Pekka", password: pass, password_confirmation: pass }

      it "is not saved" do
        expect(user).not_to be_valid
        expect(User.count).to eq(0)
      end
    end
  end
end
