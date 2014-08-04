class VideoSerializer < ApplicationSerializer
  attributes :id, :title, :url, :is_playlist, :yt_url, :category_name

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
end
