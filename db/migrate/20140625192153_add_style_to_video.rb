class AddStyleToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :style, :integer
  end
end
