class Ship < ApplicationRecord
  has_many :cells
  belongs_to :board

  validates :name, presence: true
  validates :length, numericality: {greater_than: 0, less_than: 6}
  validates_associated :cells

  def sunk?
    hits_so_far == length
  end

  def overlapping?(potential_coords)
    placed_ships = self.board.ships.select { |ship| ship.cells.count > 0 }
    return false if placed_ships.empty?

    placed_ships.each do |ship|
      ship.cells.each do |cell|
        if potential_coords.include?(cell.coordinates)
          errors.add(:overlapping, "the placement you entered overlaps with an already placed ship, try again!"
        end
      end
    end

    false
  end

  # def valid_coordinates?(coords)
  #   coords.length == 2 && Board::LETTERS.include?(coords[0]) && Board::NUMBERS.include?(coords[1])
  # end

  private

  def hits_so_far
    cells.already_guessed.count
  end
end
