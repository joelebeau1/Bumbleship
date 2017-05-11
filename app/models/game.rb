class Game < ApplicationRecord
  has_many :boards
  has_many :players, through: :boards
  has_many :ships, through: :boards

  validates :secret_key, presence: true, length: { is: 6 }
  validates :players, length: { is: 2 }
  validates :boards, length: { is: 2 }

  # validate :has_two_players
  # validate :has_two_boards

  # def has_two_players
  #   unless self.player_size == 2
  #     errors.add(:players, "game must have two players")
  #   end
  # end

  # def player_size
  #   self.players.size
  # end


  # def has_two_boards
  #   unless self.board_size == 2
  #     errors.add(:boards, "game must have two boards")
  #   end
  # end

  # def board_size
  #   self.boards.size
  # end
end
