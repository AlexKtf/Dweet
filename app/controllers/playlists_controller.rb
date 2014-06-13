class PlaylistsController < ApplicationController
  def show
    @playlist = Playlist.find(params[:id])
    @plist = VideoInfo.new(@playlist.url)
  end
end
