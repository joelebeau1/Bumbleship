class Cell < ApplicationRecord

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
