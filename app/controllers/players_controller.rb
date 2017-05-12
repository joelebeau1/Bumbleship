class PlayersController <  ApplicationController
  def new
    @game = Game.find(params[:id])
    # TODO: maybe check for multiple players better than this?
    unless @game.valid?
      @errors = @game.errors.full_messages
    end
    unless @game.players.count < 2
      @errors = ["Only two players per game, matey."]
    end
  end

  def create
    p params
    @player = Player.new(player_params)
    if @player.save
      # TODO maybe: refactor board and ship creation/linking into after_save callback for player?
      @board = Board.new
      @board.player = @player
      @game = Game.find(params[:id])
      @board.game = @game
      # TODO: incorporate correct ship names and sizes from Joe and Tove's code
      @board.ships = [Ship.create(name: "TODO", length: 2),
                      Ship.create(name: "TODO", length: 3),
                      Ship.create(name: "TODO", length: 3),
                      Ship.create(name: "TODO", length: 4),
                      Ship.create(name: "TODO", length: 5)]
      if @board.save
        # TODO maybe: refactor generate_cells into after_save callback for board?
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
