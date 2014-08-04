class CategorySerializer < ApplicationSerializer
  attributes :id, :name, :videos_count

  def videos_count
    object.videos.count
  end
end
