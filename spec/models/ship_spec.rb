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
  describe "#sunk?" do
    let(:unsunk_ship) { build(:ship) }
    xit "returns false when has no guesses" do
      unsunk_ship.cells << build(:cell) << build(:cell)
      expect(unsunk_ship.sunk?).to be false
    end
    xit "returns false when guesses less than total ship length" do
      unsunk_ship.cells << build(:cell) << build(:cell)
      unsunk_ship.cells.first.guessed = true
      expect(unsunk_ship.sunk?).to be false
    end
    xit "returns true when guesses equal total ship length" do
      unsunk_ship.cells << build(:cell) << build(:cell)
      unsunk_ship.cells.each { |cell| cell.guessed = true }
      expect(unsunk_ship.sunk?).to be true
    end
  end
end
