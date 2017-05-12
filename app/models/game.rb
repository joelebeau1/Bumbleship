class Game < ApplicationRecord
  has_many :boards
  has_many :players, through: :boards
  has_many :ships, through: :boards

  validates :secret_key, presence: true, length: { is: 6 }
  validates :players, length: { maximum: 2 }
  validates :boards, length: { maximum: 2 }

  before_validation :generate_secret_key

  def over?
    boards.any? { |board| board.ships_all_sunk? }
  end

  def winner
    winner_board = boards.find { |board| !board.ships_all_sunk? }
    winner_board.player
  end

  def current_player(id)
    #TODO >> sub 1 for session[:player_id] once player and session logic is in place
    Player.find(id)
  end

  def opp_board(id)
    boards.find do |board|
      board.player != self.current_player(id)
    end
  end

  def first_ship_sunk

  end

  def loser_board
    boards.find { |board| board.ships_all_sunk? }
  end

  def last_ship_sunk
    last_sunk_time = loser_board.ships.maximum(:sunk_time)
    ships.find_by(sunk_time: last_sunk_time)
  end

  def first_ship_sunk
    first_board_first_ship_sunk_time = boards.first.ships.minimum(:sunk_time)
    last_board_first_ship_sunk_time = boards.last.ships.minimum(:sunk_time)
    # return nil if no ships have been sunk
    return nil unless first_board_first_ship_sunk_time && last_board_first_ship_sunk_time
    if first_board_first_ship_sunk_time < last_board_first_ship_sunk_time
      ships.find_by(sunk_time: first_board_first_ship_sunk_time)
    else
      ships.find_by(sunk_time: last_board_first_ship_sunk_time)
    end
  end

  protected

  def generate_secret_key
    unless secret_key
      chars = ("a".."z").to_a.concat(("0".."9").to_a)
      self.secret_key = 6.times.inject("") do |total, n|
        total << chars.sample
      end
    end
  end
end
