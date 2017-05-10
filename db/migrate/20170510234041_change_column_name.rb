class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :ships, :player_id, :board_id
  end
end
