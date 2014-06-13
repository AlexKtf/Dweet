class Playlist < ActiveRecord::Base

  belongs_to :category

  validates :url, :category_id, presence: true

end
