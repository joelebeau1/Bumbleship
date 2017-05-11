class Board < ApplicationRecord
  belongs_to :game
  belongs_to :player
  has_many :ships
  has_many :cells

  validates :ships, length: { maximum: 5 }

  LETTERS = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
  NUMBERS = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]


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

  def coordinates
    coordinates = []
    LETTERS.each do |letter|
      NUMBERS.each do |number|
        coordinates << (letter + number)
      end
    end
    coordinates
  end

  def generate_cells
    coordinates.each do |pair|
      self.cells << Cell.create(coordinates: pair, guessed: false)
    end
  end
end
