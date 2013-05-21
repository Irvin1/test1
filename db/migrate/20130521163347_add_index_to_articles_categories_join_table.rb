class AddIndexToArticlesCategoriesJoinTable < ActiveRecord::Migration
  def change
    add_index :articles_categories, [:article_id, :category_id]
  end
end
