require 'spec_helper'

describe Beer do
  describe "with name and style" do
    let(:beer) { Beer.create name: "Koff", style: "Halpa" }
    it "is saved" do
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
  end

  describe "without a name" do
    let(:beer) { Beer.create style: "Halpa" }
    it "is not saved" do
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
  end

  describe "without a score" do
    let(:beer) { Beer.create name: "Koff" }
    it "is not saved" do
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
  end
end
