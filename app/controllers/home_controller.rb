class HomeController < ApplicationController
  
  def index
  end

  def home_items

    if stale? Video.order('created_at DESC').first

      videos = Video.order('created_at DESC').limit(10)

      respond_to do |format|
        format.json { render json: [videos, Video.videos.top_10, Video.playlists.top_10], except: :yt_url, root: false }
      end
    end
    
  end
end
