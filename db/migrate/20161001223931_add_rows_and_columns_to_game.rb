class AddRowsAndColumnsToGame < ActiveRecord::Migration[5.0]

  def change
    add_column :games, :rows, :integer, :null => false
    add_column :games, :columns, :integer, :null => false
  end

end
