class CreateCells < ActiveRecord::Migration[5.0]
  def change
    create_table :cells do |t|
      t.integer :board_id, null: false
      t.string :coordinates, null: false
      t.boolean :guessed, null: false
      t.integer :ship_id

      t.timestamps(null: false)
    end

    # add_index :cells, [:board_id, :coordinates], unique: true, name: 'board_coordinates'
  end
end
