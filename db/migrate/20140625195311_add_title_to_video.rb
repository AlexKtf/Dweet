class AddTitleToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :title, :string
    add_column :videos, :image_preview_url, :string
    add_column :videos, :embed_code, :string
  end
end
