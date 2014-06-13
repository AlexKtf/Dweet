class DestroyNameForPlaylist < ActiveRecord::Migration
  def change
    remove_column :playlists, :name, :string
  end
end
