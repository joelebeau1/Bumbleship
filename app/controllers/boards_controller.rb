class BoardsController < ApplicationController

  def setup

  end

  def play

  end

  def update
    p params
  end

  private

  def board_params
    params.require
  end

  def fire
    @game = Game.find(params[:game_id])
    @own_board = Board.find(params[:id])
    @opp_board = (game.boards - [@own_board]).first
    @result = opp_board.guess(params[:coordinates])
    if game.over?
      redirect_to game_show_path(game)
    else
      # TODO: hook up with WebSockets here
      render game_board_play(@game, @own_board)
    end
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
