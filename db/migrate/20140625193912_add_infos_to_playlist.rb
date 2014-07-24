class AddInfosToPlaylist < ActiveRecord::Migration
  def change
    add_column :playlists, :image_preview_url, :string
    add_column :playlists, :title, :string
    add_column :playlists, :embed_code, :string
    add_column :playlists, :state, :integer
  end
end
