 class CreateShips < ActiveRecord::Migration[5.0]
  def change
    create_table :ships do |t|
      t.string :name, null: false
      t.integer :length, null: false
      t.integer :player_id

      t.timestamps(null: false)
    end
  end
end
