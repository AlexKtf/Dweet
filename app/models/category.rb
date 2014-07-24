class Category < ActiveRecord::Base

  has_many :playlists, dependent: :destroy
  has_many :videos, dependent: :destroy

  validates :name, presence: true

  def ordered_items
    (videos + playlists).sort{ |a, b| b.created_at <=> a.created_at }
  end
end
