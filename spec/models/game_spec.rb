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
        game = build(:game)
        game.players << build(:player) << build(:player)
        game.valid?
        expect(game.errors.messages[:players]).to be_empty

        empty_game = build(:game)
        empty_game.valid?
        expect(empty_game.errors.messages[:players]).to be_empty

        too_full_game = build(:game)
        too_full_game.players << build(:player) << build(:player) << build(:player)
        too_full_game.valid?
        expect(too_full_game.errors.messages[:players]).to_not be_empty
      end
    end

    describe 'number of boards' do
      it 'has no more than two boards' do
        board1 = build(:board)
        board2 = build(:board)
        board3 = build(:board)
        5.times do
          board1.ships << build(:ship)
          board2.ships << build(:ship)
          board3.ships << build(:ship)
        end

        game = build(:game)
        game.boards << board1 << board2
        game.valid?
        expect(game.errors.messages[:boards]).to_not include("is too long (maximum is 2 characters)")

        one_board_game = build(:game)
        one_board_game.boards << board1
        one_board_game.valid?
        expect(one_board_game.errors.messages[:boards]).to_not include("is too long (maximum is 2 characters)")

        three_board_game = build(:game)
        one_board_game.boards << board1 << board2 << board3
        three_board_game.valid?
        expect(three_board_game.errors.messages[:boards]).to include("is too long (maximum is 2 characters)")
      end
    end
  end
end
