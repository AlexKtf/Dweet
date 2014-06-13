class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.references :artist, index: true
      t.references :playlist, index: true

      t.timestamps
    end
  end
end
