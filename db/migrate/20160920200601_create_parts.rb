class CreateParts < ActiveRecord::Migration[5.0]
  def change
    create_table :parts do |t|
      t.integer :game_id
      t.integer :picture_id
      t.integer :quantity
      t.timestamps
    end
  end
end
