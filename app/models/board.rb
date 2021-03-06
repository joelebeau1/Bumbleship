class Board < ApplicationRecord
  belongs_to :game
  belongs_to :player
  has_many :ships
  has_many :cells

  accepts_nested_attributes_for :ships
  validates :ships, length: { maximum: 5 }

  LETTERS = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
  NUMBERS = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

  def row(letter)
    self.cells.order(:coordinates).select do |cell|
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


  def guess(coordinates)
    cells.find_by(coordinates: coordinates.upcase).fire_on
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
      self.cells.create(coordinates: pair, guessed: false)
    end
    self.save
  end

  def ships_all_sunk?
    ships.all? { |ship| ship.sunk? }
  end

  def hit_miss_ratio
    # number of hits = number of cells that have been guessed and that have a ship in them
    number_of_total_guesses = cells.already_guessed.count
    number_of_hits = cells.already_guessed.where.not(ship_id: nil ).count
    # number of misses = number of cells that have been guessed and that don't have a ship in them
    number_of_misses = number_of_total_guesses - number_of_hits
    return 1.0 if number_of_misses == 0
    # number of hits / number of misses
    number_of_hits.to_f / number_of_misses.to_f
  end

  private

end
