class HomeController < ApplicationController
  
  def index
  end

  def home_items

    if stale? Category.main_category.order('created_at DESC').first

      videos = Video.order('created_at DESC').limit(10)

      respond_to do |format|
        format.json { render json: videos, except: :yt_url, root: false }
      end
    end
    
  end
end
