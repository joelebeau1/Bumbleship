class Cell < ApplicationRecord
  belongs_to :board
  has_one :ship

  validates :coordinates, presence: true, format: /\A[A-J]{1}[0-9]{1}\z/
  validates :guessed, inclusion: { in: [true, false ] }
  validates :guessed, exclusion: { in: [nil] }
end
