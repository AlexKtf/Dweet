class VideosController < ApplicationController

  def show
    video = Video.find(params[:id])
    redirect_to "/#/categories/#{video.category.slug}/#{video.slug}"
  end

  def update
    video = Video.find(params[:id])
    video.update_attributes!(video_params)

    respond_to do |format|
      format.json { render json: video, root: false }
    end
  end

  private

    def video_params
      params.require(:video).permit(:view)
    end
end
