class HomeController < ApplicationController
  
  def index
  end

  def home_items

    videos = Video.order('created_at DESC').limit(10)

    respond_to do |format|
      format.json do
        render json: videos,
        meta: {
          top_videos: ActiveModel::ArraySerializer.new(Video.videos.top_10, each_serializer: VideoSerializer),
          top_playlists: ActiveModel::ArraySerializer.new(Video.playlists.top_10, each_serializer: VideoSerializer)
        },
        except: :yt_url
      end
    end
    
  end
end
