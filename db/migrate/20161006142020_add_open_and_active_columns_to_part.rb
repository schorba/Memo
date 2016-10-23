class AddOpenAndActiveColumnsToPart < ActiveRecord::Migration[5.0]

  add_column :parts, :is_active, :boolean, default: true
  add_column :parts, :opened, :boolean, default: false

end
