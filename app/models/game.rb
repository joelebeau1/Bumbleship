class Game < ApplicationRecord
  has_many :boards
  has_many :players, through: :boards
  has_many :ships, through: :boards
end
