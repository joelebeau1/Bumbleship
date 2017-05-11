class BoardsController < ApplicationController
  def play
    @game = Game.find(params[:game_id])
    @board = Board.find(params[:id])
  end
end
