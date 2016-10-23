class AddIsCompleteColumnToGame < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :is_complete, :boolean, default: false
  end
end
