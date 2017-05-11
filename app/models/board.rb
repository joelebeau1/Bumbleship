class Board < ApplicationRecord
  belongs_to :game
  belongs_to :player
  has_many :ships
  has_many :cells

  validates :ships, length: { i3s: 5 }
  # validate :has_five_ships

  LETTERS = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
  NUMBERS = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]


  # def has_five_ships
  #   unless self.ship_size == 2
  #     errors.add(:ships, "game must have five ships")
  #   end
  # end

  # def ship_size
  #   self.ships.size
  # end

  def row(letter)
    self.cells.select do |cells|
      cell.coordinates[0] == letter
    end
  end

  def rows
    rows = []

    LETTERS.each do |letter|
      rows << self.row(letter)
    end

    return rows
  end

  def self.coordinates
    coordinates = []
    LETTERS.each do |letter|
      NUMBERS.each do |number|
        coordinates << (letter + number)
      end
    end
    coordinates
  end

  def generate_cells
    Board.coordinates.each do |pair|
      self.cells << Cell.create(coordinates: pair, guessed: false, )
    end
  end
end
