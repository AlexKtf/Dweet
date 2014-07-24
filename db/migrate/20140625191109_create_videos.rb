class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.references :playlist, index: true
      t.string :url
      t.references :category, index: true

      t.timestamps
    end
  end
end
