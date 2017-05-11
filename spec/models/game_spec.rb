require "rails_helper"

describe "Game" do
  describe "validations" do
    describe "secret_key" do
      it "must be present" do
        game = Game.new(secret_key: "123456")
        game.valid?
        expect(game.errors.messages[:secret_key]).to be_empty

        empty_game = Game.new
        empty_game.valid?
        expect(empty_game.errors.messages[:secret_key]).to_not be_empty
      end

      it 'must be 6 characters long' do
        game = Game.new(secret_key: "12345")
        game.valid?
        expect(game.errors.messages[:secret_key]).to_not be_empty
      end
    end

    describe 'number of players' do
      it 'has no more than two players' do
        game = Game.new(players: [Player.new(name: 'joe'), Player.new(name: 'simon')])
        game.valid?
        expect(game.errors.messages[:players]).to be_empty

        empty_game = build(:game_with_no_players)
        empty_game.valid?
        expect(empty_game.errors.messages[:players]).to be_empty

        too_full_game = Game.new(players: [Player.new(name: 'joe'), Player.new(name: 'simon'), Player.new(name: "stacy")])
        too_full_game.valid?
        expect(too_full_game.errors.messages[:players]).to_not be_empty
      end
    end

    describe 'number of boards' do
      it 'has no more than two boards' do
        good_ship_params = {name: "test", length: 2}
        board1 = Board.new(ships: [Ship.new(good_ship_params),
                                   Ship.new(good_ship_params),
                                   Ship.new(good_ship_params),
                                   Ship.new(good_ship_params),
                                   Ship.new(good_ship_params)])
        board2 = Board.new(ships: [Ship.new(good_ship_params),
                                   Ship.new(good_ship_params),
                                   Ship.new(good_ship_params),
                                   Ship.new(good_ship_params),
                                   Ship.new(good_ship_params)])
        board3 = Board.new(ships: [Ship.new(good_ship_params),
                                   Ship.new(good_ship_params),
                                   Ship.new(good_ship_params),
                                   Ship.new(good_ship_params),
                                   Ship.new(good_ship_params)])
        game = Game.new(boards: [board1, board2])
        game.valid?
        expect(game.errors.messages[:boards]).to_not include("is too long (maximum is 2 characters)")
        empty_game = Game.new(boards: [board1])
        empty_game.valid?
        expect(empty_game.errors.messages[:boards]).to_not include("is too long (maximum is 2 characters)")
        empty_game = Game.new(boards: [board1, board2, board3])
        empty_game.valid?
        expect(empty_game.errors.messages[:boards]).to include("is too long (maximum is 2 characters)")
      end
    end
  end
end
