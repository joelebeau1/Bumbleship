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
    #TODO uncomment so we can use this after styling is set
    @game = Game.find(params[:id])
    if @game.over?
      session[:player_id] = nil
      @winner = @game.winner
      @player_1 = @game.players.first
      @player_2 = @game.players.last
      @player_1_total_shots_fired = @player_1.boards.find_by(game_id: @game.id).cells.already_guessed.count
      @player_1_hit_miss_ratio = @player_1.boards.find_by(game_id: @game.id).hit_miss_ratio
      @player_2_total_shots_fired = @player_2.boards.find_by(game_id: @game.id).cells.already_guessed.count
      @player_2_hit_miss_ratio = @player_2.boards.find_by(game_id: @game.id).hit_miss_ratio
      @first_ship_sunk = @game.first_ship_sunk
      @last_ship_sunk = @game.last_ship_sunk
    else
      # game not over, redirect to board play page
      player = Player.find(session[:player_id])
      board = player.boards.find_by(game_id: @game.id)
      redirect_to game_board_play_path(@game, board)
    end
  end
end
