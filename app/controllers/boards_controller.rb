class BoardsController < ApplicationController
  def play
    @game = Game.find(params[:game_id])
    @own_board = Board.find(params[:id])
    @opp_board = @game.opp_board
  end

  def setup
  end

  def update
    @board = Board.find(params[:id])

    board_params.each do |_placeholder, attributes|
      ship = @board.ships.where(name: attributes[:name]).first
      unless valid_coordinates?(attributes[:coordinate])
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
        # BUG: binding.pry was not hit when run from this linke
        ship.cells << @board.cells.where(coordinates: coords).first
        ship.save
      end
    end

    if all_ships_valid?(@board)
      @board.save
      Game.find(params[:game_id]).save
      redirect_to "/games/#{params[:game_id]}/boards/#{params[:id]}/play"
    else
      @errors = []
      @board.ships.each { |ship| @errors << ship.errors.full_messages }
      render 'setup'
    end
  end

  def fire
    @coords = params[:coordinates].upcase
    @game = Game.find(params[:game_id])
    @own_board = Board.find(params[:id])
    if @coords =~ /\A[A-J]{1}[0-9]{1}\z/
      # coordinates are correctly formatted
      @opp_board = (@game.boards - [@own_board]).first
      @result = @opp_board.guess(@coords)
      if @game.over?
        # there is a winner, go to game show page
        redirect_to game_show_path(@game)
      else
        # TODO: hook up with WebSockets here
        p @result
        flash[:notice] = "We'll change this later, but for now the result is #{@result}"
        redirect_to game_board_play_path(@game, @own_board)
      end
    else
      # coordinates entered in error
      @fire_error = "Yarr, those don't be seaworthy coordinates"
      # TODO: update this to be the correct view file
      render "_fire_form"
    end
  end

  private
  def board_params
    params.require(:board).permit(ship1: [:name, :coordinate, :length, :alignment], ship2: [:name, :coordinate, :length, :alignment], ship3: [:name, :coordinate, :length, :alignment], ship4: [:name, :coordinate, :length, :alignment], ship5: [:name, :coordinate, :length, :alignment])
  end

  def all_ships_valid?(board)
    board.ships.each do |ship|
      return false if ship.errors.any?
    end
    true
  end

  def overlapping?(board, potential_coords)
    placed_ships = board.ships.select { |ship| ship.cells.count > 0 }
    return false if placed_ships.empty?

    placed_ships.each do |ship|
      ship.cells.each do |cell|
        return true if potential_coords.include?(cell.coordinates)
      end
    end

    false
  end

  def valid_coordinates?(coords)
    coords.length == 2 && Board::LETTERS.include?(coords[0]) && Board::NUMBERS.include?(coords[1])
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

    elsif direction == "right"
      count = 0
      index = Board::NUMBERS.index(starting_coordinate[1]) + 1

      while count <= cells_to_add do
        return false if Board::NUMBERS.length == index + count
        cells << (starting_coordinate[0] + Board::NUMBERS[index + count])
        count += 1
      end
    else
      false
    end

    cells << starting_coordinate
    cells
  end


end
