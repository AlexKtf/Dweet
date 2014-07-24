class VideosController < ApplicationController

  def show
    video = Video.find(params[:id])

    respond_to do |format|
      format.json do
        render json: video, include: [:category]
      end
    end
  end
end
