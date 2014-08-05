class CategorySerializer < ApplicationSerializer
  attributes :id, :name, :videos_count, :slug

  def slug
    object.slug
  end

  def videos_count
    object.videos.count
  end
end
