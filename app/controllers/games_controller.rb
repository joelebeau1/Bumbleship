class GamesController <  ApplicationController
  def index

  end

  def new

  end

  def join
    secret_key = params[:secret_key]
    if (game = Game.find_by(secret_key: secret_key))
      redirect_to new_game_player(game)
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
  end
end
