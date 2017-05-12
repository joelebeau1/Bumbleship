class GamesController <  ApplicationController
  def index

  end

  def new

  end

  def create

  end

  def show
    @numbers = (0..9)
    @letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
  end
end
