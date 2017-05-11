class Board < ApplicationRecord
  belongs_to :game
  belongs_to :player
  has_many :ships
  has_many :cells

  validates :ships, length: { is: 5 }

  accepts_nested_attributes_for :ships
end
