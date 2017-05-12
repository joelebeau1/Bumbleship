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


  def current_player
    #TODO >> sub 1 for session[:player_id] once player and session logic is in place
    Player.find(1)
  end

  def opp_board
    boards.find do |board|
      board.player != self.current_player
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
