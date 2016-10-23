class CreateCategoriesGames < ActiveRecord::Migration[5.0]
  def change
    create_table :categories_games do |t|
        t.column :category_id, :integer, :null => false
        t.column :game_id, :integer, :null => false
    end
  end
end
