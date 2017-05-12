class Game < ApplicationRecord
  has_many :boards
  has_many :players, through: :boards
  has_many :ships, through: :boards

  validates :secret_key, presence: true, length: { is: 6 }
  validates :players, length: { maximum: 2 }
  validates :boards, length: { maximum: 2 }


  def current_player
    #TODO >> sub 1 for session[:player_id] once player and session logic is in place
    Player.find(1)
  end

  def opp_board
    boards.find do |board|
      board.player != self.current_player
    end
  end
end
