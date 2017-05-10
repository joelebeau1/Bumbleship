class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :secret_key, null: false

      t.timestamps(null: false)
    end

    add_index :games, :secret_key, unique: true
  end
end
