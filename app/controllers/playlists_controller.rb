class PlaylistsController < ApplicationController

  def show
    playlist = Playlist.find(params[:id])

    respond_to do |format|
      format.json do
        render json: playlist, include: [:category, videos: { only: :url }]
      end
    end
  end
end
