class Ship < ApplicationRecord
  has_many :cells
  belongs_to :board
  delegate :player, to: :board

  validates :name, presence: true
  validates :length, numericality: {greater_than: 0, less_than: 6}

  def sunk?
    hits_so_far == length
  end

  private

  def hits_so_far
    cells.already_guessed.count
  end
end
