class AddUrlToPlaylist < ActiveRecord::Migration
  def change
    add_column :playlists, :url, :string
  end
end
