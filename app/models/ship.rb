class Ship < ApplicationRecord
  has_many :cells
  belongs_to :board

end
