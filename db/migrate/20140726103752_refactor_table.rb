class RefactorTable < ActiveRecord::Migration
  def change
    drop_table :videos
    drop_table :playlists
    create_table :videos do |t|
      t.string :url
      t.string :title
      t.string :image_preview_url
      t.integer :duration
      t.boolean :is_playlist, default: false
      t.string :first_video_url

      t.timestamps
    end
  end
end
