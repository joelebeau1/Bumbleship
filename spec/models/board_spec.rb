require "rails_helper"

describe "Board" do
  describe "validations" do
    it "has 5 and only 5 ships" do
      good_ship_params = {name: "test", length: 2}
      board = Board.new(ships: [Ship.new(good_ship_params),
                                Ship.new(good_ship_params),
                                Ship.new(good_ship_params),
                                Ship.new(good_ship_params),
                                Ship.new(good_ship_params)])
      board.valid?
      expect(board.errors.messages[:ships]).to be_empty
      bad_board = Board.new(ships: [Ship.new(good_ship_params),
                                    Ship.new(good_ship_params),
                                    Ship.new(good_ship_params),
                                    Ship.new(good_ship_params)])
      bad_board.valid?
      expect(bad_board.errors.messages[:ships]).to_not be_empty
      bad_board = Board.new(ships: [Ship.new(good_ship_params),
                                    Ship.new(good_ship_params),
                                    Ship.new(good_ship_params),
                                    Ship.new(good_ship_params),
                                    Ship.new(good_ship_params),
                                    Ship.new(good_ship_params)])
      bad_board.valid?
      expect(bad_board.errors.messages[:ships]).to_not be_empty
    end
  end
end
