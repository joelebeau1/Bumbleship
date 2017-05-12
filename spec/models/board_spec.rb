require "rails_helper"

describe "Board" do
  describe "validations" do
    it "has no more than 5 ships" do
      board = build(:board)
      six_ship_board = build(:board)
      5.times do
        board.ships << build(:ship)
        six_ship_board.ships << build(:ship)
      end
      six_ship_board.ships << build(:ship)

      board.valid?
      expect(board.errors.messages[:ships]).to be_empty

      six_ship_board.valid?
      expect(six_ship_board.errors.messages[:ships]).to_not be_empty
    end
  end
  describe "#generate_cells" do
    before(:each) do
      @board = build(:board)
      @board.player = build(:player)
      @board.game = build(:game)
      @board.save!
      @board.generate_cells
    end
    it "generates cell object" do
      expect(@board.cells).to all( be_a(Cell) )
    end
    it "generates 100 objects" do
      expect(@board.cells.count).to eq 100
    end
    it "generates cells that have not been guessed" do
      all_guessed = @board.cells.pluck(:guessed)
      expect(all_guessed).to all( be false )
    end
    it "contains no duplicate coordinates" do
      all_coordinates = @board.cells.pluck(:coordinates)
      expect(all_coordinates.uniq.length).to eq 100
    end
  end

  describe "#guess" do
    describe "when the game is not over" do
      it "returns 'guessed' if cell was already guessed"
      it "returns 'miss' if that cell does not contain a ship"
      it "returns 'hit' if a ship is hit but not sunk"
      it "returns the ship's name if the ship is sunk"
    end
    describe "when the game is over" do
      it "displays"
    end
  end
end
