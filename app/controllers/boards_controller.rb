class BoardsController < ApplicationController
  def play
    @game = Game.find(params[:game_id])
    @own_board = Board.find(params[:id])
    @opp_board = @game.opp_board(session[:player_id])
  end

  def setup
  end

  def update
    @board = Board.find(params[:id])
    board_params.each do |_placeholder, attributes|
      ship = @board.ships.where(name: attributes[:name]).first
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
      # ship.save
      # end
      # break if ship.errors.any?
      coordinates.each do |coords|
        # BUG: binding.pry was not hit when run from this linke
        p "&&&&&&&&&&&&&&&&&&&&"
        p ship.cells
        p @board.cells.where(coordinates: coords).first
        p "&&&&&&&&&&&&&&&&&&&&"
        ship.cells << @board.cells.where(coordinates: coords.upcase).first
        ship.save
      end
    end

    # if all_ships_valid?(@board)
      @board.save
      Game.find(params[:game_id]).save
      redirect_to "/games/#{params[:game_id]}/boards/#{params[:id]}/play"
    # else
    #   @errors = []
    #   @board.ships.each { |ship| @errors << ship.errors.full_messages }
    #   render 'setup'
    # end
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

  # def all_ships_valid?(board)
  #   board.ships.each do |ship|
  #     return false if ship.errors.any?
  #   end
  #   true
  # end

  def coordinates_occupied(ship, attributes)
    cells = []
    starting_coordinate = attributes[:coordinate]
    direction = attributes[:alignment]
    cells_to_add = attributes[:length].to_i - 1

    p "*(((((*())(**(&*(Y&(*"
    p starting_coordinate
    p "*(((((*())(**(&*(Y&(*"

    if direction == "down"
      count = 0
      index = Board::LETTERS.index(starting_coordinate[0].upcase) + 1

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
    cells
  end


end
