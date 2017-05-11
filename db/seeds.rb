# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

joe = Player.find_or_create_by(name: 'Joe')
stacy = Player.find_or_create_by(name: 'Stacy')

game = Game.new(secret_key: '123456')
joe_board = Board.new(player: joe, game: game)
stacy_board = Board.new(player: stacy, game: game)


# game.boards.each do |board|

Ship.create!(name: "test", length: 3, board: joe_board)
Ship.create!(name: "test", length: 3, board: joe_board)
Ship.create!(name: "test", length: 3, board: joe_board)
Ship.create!(name: "test", length: 3, board: joe_board)
Ship.create!(name: "test", length: 3, board: joe_board)

Ship.create!(name: "test", length: 3, board: stacy_board)
Ship.create!(name: "test", length: 3, board: stacy_board)
Ship.create!(name: "test", length: 3, board: stacy_board)
Ship.create!(name: "test", length: 3, board: stacy_board)
Ship.create!(name: "test", length: 3, board: stacy_board)

joe_board.save
stacy_board.save
game.save


