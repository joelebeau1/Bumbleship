class GamesController <  ApplicationController
  def index

  end

  def new

  end

  def join
    secret_key = params[:secret_key]
    if (game = Game.find_by(secret_key: secret_key))
      redirect_to new_game_player_path(game)
    else
      @errors = ["Secret key not found, matey... :("]
      render :new
    end
  end

  def create
    @game = Game.new
    if @game.save
      redirect_to new_game_player_path(@game)
    else
      @errors = @game.errors.full_messages
      render :new
    end
  end

  def show
    @numbers = (0..9)
    @letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
    #TODO check if game is over
    @game = Game.find(params[:id])
    @winner = @game.winner
    @player_1 = @game.players.first
    @player_2 = @game.players.last
    @player_1_hit_miss_ratio = @player_1.boards.where(game_id: @game.id).hit_miss_ratio
    @player_2_hit_miss_ratio = @player_2.boards.where(game_id: @game.id).hit_miss_ratio
    @first_ship_sunk = @game.first_ship_sunk
    @last_ship_sunk = @game.last_ship_sunk
  end
end
