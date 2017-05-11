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
      it 'must have two players' do
        game = Game.new(players: [Player.new(name: 'joe'), Player.new(name: 'simon')])
        game.valid?
        expect(game.errors.messages[:players]).to be_empty

        empty_game = Game.new
        empty_game.valid?
        expect(empty_game.errors.messages[:players]).to_not be_empty
      end
    end

    describe 'number of boards' do
      it 'must have two boards' do
        game = Game.new(boards: [Board.new(player: Player.new(name: "test")), Board.new(player: Player.new(name: "test"))])
        game.valid?
        expect(game.errors.messages[:boards]).to be_empty

        empty_game = Game.new
        empty_game.valid?
        expect(empty_game.errors.messages[:boards]).to_not be_empty
      end
    end
  end
end
