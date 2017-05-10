class CreateBoards < ActiveRecord::Migration[5.0]
  def change
    create_table :boards do |t|
      t.integer :game_id, null: false
      t.integer :player_id, null: false

      t.timestamps(null: false)
    end
  end
end
