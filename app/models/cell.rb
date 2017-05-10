class Cell < ApplicationRecord
  belongs_to :board
  belongs_to :ship
end
