class Cell < ApplicationRecord
  belongs_to :board
  belongs_to :ship

  validates :coordinates, presence: true, format: /\A[A-J]{1}[0-9]{1}\z/
  validates :guessed, inclusion: { in: [true, false ] }
  validates :guessed, exclusion: { in: [nil] }

  def status
    if guessed && ship_id
      "hit"
    elsif guessed && !ship_id
      "miss"
    elsif !guessed && ship_id

    else
      nil
    end
  end
end
