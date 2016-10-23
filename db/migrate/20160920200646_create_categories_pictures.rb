class CreateCategoriesPictures < ActiveRecord::Migration[5.0]
  def self.up
    create_table :categories_pictures do |t|
      t.column :category_id, :integer, :null => false
      t.column :picture_id, :integer, :null => false

    end
  end

  def self.down
    drop_table :categories_pictures
  end
end
