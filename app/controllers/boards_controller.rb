class BoardsController < ApplicationController

  def setup

  end

  def play

  end
# "ship4"=>{"name"=>"Frigate", "coordinate"=>"A2", "length"=>"4", "alignment"=>"down"}
  def update
    @board = Board.find(params[:id])

    params[:board].each_pair do |ship_num, attributes|
      ship = @board.ships.where(name: attributes[:name])

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



  end

  private
  def board_params
    params.require(:board).permit(ships_attributes: [:coordinate, :length, :alignment, :name])
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
    LETTERS.include?(coords[0]) && NUMBERS.include?(coords[1]) && coords.length == 2
  end

LETTERS = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
NUMBERS = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

  def coordinates_occupied(args)
    cells = []
    starting_coordinate = args[:coordinate]
    direction = args[:alignment]
    cells_to_add = args[:length] - 1

    if direction == "down"
      count = 0
      index = LETTERS.index(starting_coordinate[0]) + 1

      while count <= cells_to_add do
        return false if LETTERS.length == index + count
        cells << (LETTERS[index + count] + starting_coordinate[1]
        count += 1
      end

    elsif direction == "right"
      count = 0
      index = NUMBERS.index(starting_coordinate[1]) + 1

      while count <= cells_to_add do
        return false if NUMBERS.length == index + count
        cells << (NUMBERS[index + count] + starting_coordinate[0]
        count += 1
      end
    end

    cells << starting_coordinate
    cells
  end


end
  # Error check:
    # Valid coordinate DONE
    # Overlaps already placed ships
    # Extending past edge of board DONE

  # If valid...
    # Create cells with coordinates and associate

  # If invalid...
    # Add custom error message to ship with ship name, reason for error
