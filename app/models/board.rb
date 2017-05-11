class Board < ApplicationRecord
  def row(letter)
    self.cells.select do |cell|
      cell.coordinates[0] == letter
    end
  end

  def rows
    letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
    rows = []

    letters.each do |letter|
      rows << self.row(letter)
    end

    return rows
  end

end
