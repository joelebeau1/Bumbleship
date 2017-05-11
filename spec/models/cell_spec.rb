require "rails_helper"

describe "Cell" do
  describe "validations" do
    describe "coordinates" do
      it "has coordinates" do
        cell = Cell.new(coordinates: "A2")
        cell.valid?
        expect(cell.errors.messages[:coordinates]).to be_empty
      end

      it "matches format (eg: A5, B2, etc)" do
        cell = Cell.new(coordinates: "A2")
        cell.valid?
        expect(cell.errors.messages[:coordinates]).to be_empty
        bad_cell = Cell.new(coordinates: "2")
        bad_cell.valid?
        expect(bad_cell.errors.messages[:coordinates]).to_not be_empty
        bad_cell = Cell.new(coordinates: "A22")
        bad_cell.valid?
        expect(bad_cell.errors.messages[:coordinates]).to_not be_empty
        bad_cell = Cell.new(coordinates: "AA")
        bad_cell.valid?
        expect(bad_cell.errors.messages[:coordinates]).to_not be_empty
        bad_cell = Cell.new(coordinates: "L9")
        bad_cell.valid?
        expect(bad_cell.errors.messages[:coordinates]).to_not be_empty
        bad_cell = Cell.new(coordinates: "a2")
        bad_cell.valid?
        expect(bad_cell.errors.messages[:coordinates]).to_not be_empty
        bad_cell = Cell.new(coordinates: "22")
        bad_cell.valid?
        expect(bad_cell.errors.messages[:coordinates]).to_not be_empty
      end
    end
    describe "guessed" do
      it "is either true or false" do
        cell = Cell.new(guessed: true)
        cell.valid?
        expect(cell.errors.messages[:guessed]).to be_empty
        bad_cell = Cell.new(guessed: nil)
        bad_cell.valid?
        expect(bad_cell.errors.messages[:guessed]).to_not be_empty
      end
    end
  end
end
