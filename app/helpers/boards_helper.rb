module BoardsHelper
  def own_display(cell)
    case cell.status
    when "hit"
      #placeholder for "hit" display
    when "miss"
      #placeholder for "miss" display
    when "ship"
      #placeholder for "miss" display
    else
      #placeholder for "water" display
    end
  end

  def opponent_display(cell)
    case cell.status
    when "hit"
      #placeholder for "hit" display
    when "miss"
      #placeholder for "miss" display
    else
      #placeholder for "water" display
    end
  end
end
