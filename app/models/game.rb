class Game < ApplicationRecord
  has_many :boards
  has_many :players, through: :boards
  has_many :ships, through: :boards

  validates :secret_key, presence: true, length: { is: 6 }
  validates :players, length: { maximum: 2 }
  validates :boards, length: { maximum: 2 }
end
