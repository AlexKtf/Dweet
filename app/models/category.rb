class Category < ActiveRecord::Base

  has_many :playlists, dependent: :destroy

  validates :name, presence: true
end
