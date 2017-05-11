require "rails_helper"

describe "Player" do
  describe "validations" do
    it "must have a name" do
      expect(Player.new(name: "test")).to be_valid
      expect(Player.new).to be_invalid
    end
  end
end
