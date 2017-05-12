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
      session[:player_id] @player_1.id
      # TODO maybe: refactor board and ship creation/linking into after_save callback for player?
      @board = Board.new
      @board.player = @player
      @game = Game.find(params[:id])
      @board.game = @game
      @board.ships = [Ship.create(name: "Queen Anne's Revenge", length: 5),
                      Ship.create(name: "Frigate", length: 4),
                      Ship.create(name: "Galleon", length: 3),
                      Ship.create(name: "Sloop", length: 2),
                      Ship.create(name: "Galley", length: 3)]
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
