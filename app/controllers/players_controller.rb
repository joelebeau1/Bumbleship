class PlayersController <  ApplicationController
  def new

  end

  def create
    p params
    @player = Player.new(player_params)
    if @player.save
      # REFACTOR: move some of this stuff into after_save callbacks for player?
      @board = Board.new
      @board.player = @player
      @game = Game.find(params[:id])
      @board.game = @game
      # TODO: incorporate correct ship types from Joe and Tove's code
      @board.ships = [Ship.create(name: "TODO", length: 2),
                      Ship.create(name: "TODO", length: 3),
                      Ship.create(name: "TODO", length: 3),
                      Ship.create(name: "TODO", length: 4),
                      Ship.create(name: "TODO", length: 5)]
      if @board.save
        @board.generate_cells
        redirect_to game_board_setup_path(@game, @board)
      else
        @errors = @board.errors.full_messages
        render :new
      end
    else
      @errors = @player.errors.full_messages
      render :new
    end
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end
end
