class VideosController < ApplicationController

  def show
    video = Video.find(params[:id])
    redirect_to  root_path + "/#/categories/#{video.category.id}/#{video.id}"
  end
end
