class BoardsController < ApplicationController
  def play
    @game = Game.find(params[:game_id])
    @own_board = Board.find(params[:id])
    @opp_board = @game.opp_board
  end

  def setup
  end

  def update
    p params
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
    params.require
  end

  # STYLES: input text field font size; side-by-side?

  # Iterate through form fields

  # Pull coordinates & orientation from form

  # Error check:
    # Valid coordinate
    # Overlaps already placed ships
    # Extending past edge of board

  # If valid...
    # Calculate cells occupied by ship & associate

  # If invalid...
    # Add custom error message to ship with ship name, reason for error

end
