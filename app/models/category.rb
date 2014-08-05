class Category < ActiveRecord::Base

  has_many :videos, dependent: :destroy

  validates :name, presence: true

  def top_videos
    videos.select('videos.id, videos.title, videos.image_preview_url, videos.is_playlist')
    .order('videos.created_at DESC')
    .limit(5)
  end

  def slug
    "#{id}-#{name.parameterize}"
  end
end
