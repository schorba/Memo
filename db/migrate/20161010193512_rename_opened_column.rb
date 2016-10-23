class RenameOpenedColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :parts, :opened, :is_opened
  end
end
