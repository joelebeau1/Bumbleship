# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

game = Game.find_or_create_by(secret_key: '123456')

joe = Player.find_or_create_by(name: 'Joe')
stacy = Player.find_or_create_by(name: 'Stacy')

joe_board = Board.new(player: joe, game: game)

Ship.create(name: "joe_ship_1", length: 1, board: joe_board)
Ship.create(name: "joe_ship_2", length: 2, board: joe_board)
Ship.create(name: "joe_ship_3", length: 3, board: joe_board)
Ship.create(name: "joe_ship_4", length: 4, board: joe_board)
Ship.create(name: "joe_ship_5", length: 5, board: joe_board)

stacy_board = Board.new(player: stacy, game: game)

Ship.create(name: "stacy_ship_1", length: 1, board: stacy_board)
Ship.create(name: "stacy_ship_2", length: 2, board: stacy_board)
Ship.create(name: "stacy_ship_3", length: 3, board: stacy_board)
Ship.create(name: "stacy_ship_4", length: 4, board: stacy_board)
Ship.create(name: "stacy_ship_5", length: 5, board: stacy_board)

joe_board.save

stacy_board.save

joe_board.generate_cells
stacy_board.generate_cells
