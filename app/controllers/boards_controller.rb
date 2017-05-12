class BoardsController < ApplicationController

  def setup

  end

  def play

  end

  def update
    @board = Board.find(params[:id])

    params[:board].each_pair do |ship_num, attributes|
      ship = @board.ships.where(name: attributes[:name]).first
      if !valid_coordinates?(attributes[:coordinate])
        ship.errors[:base] << "Invalid starting coordinate for your #{attributes[:name]}, please choose a valid coordinate"
      end
      break if ship.errors.any?

      coordinates = coordinates_occupied(attributes)
      break if !coordinates

      if overlapping?(@board, coordinates)
        ship.errors[:base] << "Your #{attributes[:name]} is overlapping with another ship, please choose a different place for your #{attributes[:name]}"
      end
      break if ship.errors.any?

      coordinates.each do |coords|
        ship.cells << Board.cells.where(coordinates: coords)
      end
    end

    if all_ships_valid?(@board)
      redirect_to "/games/#{params[:game_id]}/boards/#{params[:id]}/play"
    else
      @errors = []
      @board.ships.each { |ship| @errors << ship.errors.full_messages }
      render 'setup'
    end
  end

  private
  def board_params
    params.require(:board).permit(ships_attributes: [:coordinate, :length, :alignment, :name])
  end

  def all_ships_valid?(board)
    board.ships.each do |ship|
      return false if ship.errors.any?
      ship.save
    end
    true
  end

  def overlapping?(board, potential_coords)
    placed_ships = board.ships.select { |ship| ship.cells.count > 0 }
    return true if placed_ships.empty?

    placed_ships.each do |ship|
      ship.cells.each do |cell|
        return true if potential_coords.include?(cell.coordinates)
      end
    end

    false
  end

  def valid_coordinates?(coords)
    Board::LETTERS.include?(coords[0]) && Board::NUMBERS.include?(coords[1]) && coords.length == 2
  end


  def coordinates_occupied(args)
    cells = []
    starting_coordinate = args[:coordinate]
    direction = args[:alignment]
    cells_to_add = args[:length].to_i - 1

    if direction == "down"
      count = 0
      index = Board::LETTERS.index(starting_coordinate[0]) + 1

      while count <= cells_to_add do
        return false if Board::LETTERS.length == index + count
        cells << (Board::LETTERS[index + count] + starting_coordinate[1])
        count += 1
      end

    else
      count = 0
      index = Board::NUMBERS.index(starting_coordinate[1]) + 1

      while count <= cells_to_add do
        return false if Board::NUMBERS.length == index + count
        cells << (Board::NUMBERS[index + count] + starting_coordinate[0])
        count += 1
      end
    end

    cells << starting_coordinate
    cells
  end


end
