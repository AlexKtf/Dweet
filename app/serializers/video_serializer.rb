class VideoSerializer < ApplicationSerializer
  attributes :id, :title, :url, :is_playlist, :slug, :image_preview_url, :yt_url, :main_category_slug, :category_name, :category_slug

  def yt_url
    if object.is_playlist
      "//youtube.com/embed/#{object.first_video_url}?list=#{object.url}"
    else
      "//youtube.com/embed/#{object.url}"
    end
  end

  def category_name
    object.category.name
  end

  def main_category_slug
    if object.category.main_category_id.present?
      return object.category.main_category.slug
    else
      return object.category.slug
    end
  end

  def slug
    object.slug
  end

  def category_slug
    object.category.slug
  end
end
