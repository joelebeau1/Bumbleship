class BoardsController < ApplicationController

  def setup

  end

  def play

  end

  def update
    p params
  end

  private

  def board_params
    params.require
  end


  # STYLES: input text field font size; side-by-side?

  # Iterate through form fields

  # Pull coordinates & orientation from form

  # Error check:
    # Valid coordinate
    # Overlaps already placed ships
    # Extending past edge of board

  # If valid...
    # Calculate cells occupied by ship & associate

  # If invalid...
    # Add custom error message to ship with ship name, reason for error

end
