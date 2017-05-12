class Game < ApplicationRecord
  has_many :boards
  has_many :players, through: :boards
  has_many :ships, through: :boards

  validates :secret_key, presence: true, length: { is: 6 }
  validates :players, length: { maximum: 2 }
  validates :boards, length: { maximum: 2 }

  before_save :generate_secret_key

  def over?
    boards.any? { |board| board.ships_all_sunk? }
  end

  protected

  def generate_secret_key
    chars = ("a".."z").to_a.concat(("0".."9").to_a)
    self.secret_key = 6.times.inject("") do |total, n|
      total << chars.sample
    end
  end
end
