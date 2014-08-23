class AddMainCategoryToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :main_category_id, :integer
  end
end
