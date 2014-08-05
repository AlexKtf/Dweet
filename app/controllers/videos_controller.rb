class VideosController < ApplicationController

  def show
    video = Video.find(params[:id])
    redirect_to "/#/categories/#{video.category.slug}/#{video.slug}"
  end
end
