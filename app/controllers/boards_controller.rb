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
    p "%%%%%%%%%%%%%%%%%%%%%%%%%"
    p board_params.length
    p "%%%%%%%%%%%%%%%%%%%%%%%%%"
    board_params.each do |_placeholder, attributes|
      p "!" * 16
      p _placeholder
      p attributes
      p "!" * 16
      ship = @board.ships.where(name: attributes[:name]).first
      puts "#{ship.name} BEFORE BREAK ONE ================!"
      # unless valid_coordinates?(attributes[:coordinate])
      #   ship.errors[:base] << "Invalid starting coordinate for your #{attributes[:name]}, please choose a valid coordinate"
      #   ship.save
      # end
      # break if ship.errors.any?
      # puts "#{ship.name} AFTER BREAK ONE ================"

      coordinates = coordinates_occupied(ship, attributes)
      # break if !coordinates
      # puts "#{ship.name} AFTER BREAK TWo ================"

      # if overlapping?(@board, coordinates)
      #   ship.errors[:base] << "Your #{attributes[:name]} is overlapping with another ship, please choose a different place for your #{attributes[:name]}"
      #   ship.save
      ship.save
      # end
      p ship.errors
      break if ship.errors.any?
      puts "#{ship.name} AFTER BREAK Three ================"

      coordinates.each do |coords|
        # BUG: binding.pry was not hit when run from this linke
        ship.cells << @board.cells.where(coordinates: coords).first
        ship.save
      end
    end

    if all_ships_valid?(@board)
      p "MORE SHIT"
      @board.save
      Game.find(params[:game_id]).save
      redirect_to "/games/#{params[:game_id]}/boards/#{params[:id]}/play"
    else
      p "MORE SHIT D:"
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

  .permit(array: [])

  def all_ships_valid?(board)
    p "+"
    p board.ships
    p "+"
    board.ships.each do |ship|
      p "-"
      p ship.errors
      p "-"
      return false if ship.errors.any?
    end
    true
  end

  def coordinates_occupied(ship, attributes)
    cells = []
    starting_coordinate = attributes[:coordinate]
    direction = attributes[:alignment]
    cells_to_add = attributes[:length].to_i - 1

    if direction == "down"
      count = 0
      index = Board::LETTERS.index(starting_coordinate[0]) + 1

      while count < cells_to_add do
        return false if Board::LETTERS.length == index + count
        cells << (Board::LETTERS[index + count] + starting_coordinate[1])
        count += 1
      end

    elsif direction == "right"
      count = 0
      index = Board::NUMBERS.index(starting_coordinate[1]) + 1

      while count < cells_to_add do
        return false if Board::NUMBERS.length == index + count
        cells << (starting_coordinate[0] + Board::NUMBERS[index + count])
        count += 1
      end
    else
      false
    end

    cells << starting_coordinate
    cells.each { |coord| ship.cells.create(coordinates: coord, guessed: false, board: ship.board)}
  end


end
