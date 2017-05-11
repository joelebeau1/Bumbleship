class Ship < ApplicationRecord
  has_many :cells
  belongs_to :board

  validates :name, presence: true
  validates :length, numericality: {greater_than: 0, less_than: 6}
end
