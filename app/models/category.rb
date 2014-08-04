class Category < ActiveRecord::Base

  has_many :videos, dependent: :destroy

  validates :name, presence: true

  def top_videos
    videos.order('videos.created_at DESC').limit(9)
  end
end
