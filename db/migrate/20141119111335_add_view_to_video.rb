class AddViewToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :view, :integer, default: 0
  end
end
