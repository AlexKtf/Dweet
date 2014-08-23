class Category < ActiveRecord::Base

  has_many :videos, dependent: :destroy

  has_many :subcategories, class_name: 'Category', foreign_key: 'main_category_id'
  belongs_to :main_category, class_name: 'Category', foreign_key: 'main_category_id'

  validates :name, presence: true

  def top_videos
    subcategories_videos.select('videos.id, videos.title, videos.image_preview_url, videos.is_playlist')
    .order('videos.created_at DESC')
    .limit(5)
  end

  def subcategories_videos
    Video.joins(:category).where('categories.main_category_id = ?', self.id)
  end

  def slug
    "#{id}-#{name.parameterize}"
  end

  class << self

    def main_category
      where(main_category_id: nil)
    end
  end
end
