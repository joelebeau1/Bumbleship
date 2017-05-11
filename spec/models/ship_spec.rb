require "rails_helper"

describe "Ship" do
  describe "validations" do
    it "must have a name" do
      ship = Ship.new(name: "test", length: 2)
      ship.valid?
      expect(ship.errors.messages[:name]).to be_empty
      bad_ship = Ship.new
      bad_ship.valid?
      expect(bad_ship.errors.messages[:name]).to_not be_empty
    end

    it "must have a length between 1 and 5 inclusive" do
      ship = Ship.new(length: 3)
      ship.valid?
      expect(ship.errors.messages[:length]).to be_empty
      bad_ship = Ship.new(length: 6)
      bad_ship.valid?
      expect(bad_ship.errors.messages[:length]).to_not be_empty
      bad_ship = Ship.new(length: 0)
      bad_ship.valid?
      expect(bad_ship.errors.messages[:length]).to_not be_empty
      bad_ship = Ship.new
      bad_ship.valid?
      expect(bad_ship.errors.messages[:length]).to_not be_empty
    end
  end
end
