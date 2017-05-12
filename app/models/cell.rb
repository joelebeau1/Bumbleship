class Cell < ApplicationRecord
  belongs_to :board
  belongs_to :ship, optional: true

  validates :coordinates, presence: true, format: /\A[A-J]{1}[0-9]{1}\z/
  validates :guessed, inclusion: { in: [true, false ] }
  validates :guessed, exclusion: { in: [nil] }

  scope :already_guessed, -> { where(guessed: true) }

  def own_status
    if guessed && ship_id
      "hit"
    elsif guessed && !ship_id
      "miss"
    elsif !guessed && ship_id
      "ship"
    else
      "water"
    end
  end

  def opponent_status
    if guessed && ship_id
      "hit"
    elsif guessed && !ship_id
      "miss"
    else
      "water"
    end
  end

  def fire_on
    return "guessed" if guessed
    update(guessed: true)
    return "miss" unless ship
    ship.sunk? ? ship.name : "hit"
  end
end
