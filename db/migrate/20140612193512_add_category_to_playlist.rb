class AddCategoryToPlaylist < ActiveRecord::Migration
  def change
    add_reference :playlists, :category, index: true
  end
end
