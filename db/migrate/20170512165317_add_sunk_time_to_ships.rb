class AddSunkTimeToShips < ActiveRecord::Migration[5.0]
  def change
    add_column :ships, :sunk_time, :datetime
  end
end
