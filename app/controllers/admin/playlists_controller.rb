class Admin::PlaylistsController < Admin::BaseController

  def index
    @categories = Category.all
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params)
    if @playlist.save
      redirect_to admin_category_path(params[:playlist][:category_id]), notice: 'Success!'
    else
      redirect_to admin_category_path(params[:playlist][:category_id]), alert: 'La playlist est introuvable'
    end
  end

  def show
    @playlist = Playlist.find(params[:id])
    @plist = VideoInfo.new(@playlist.url)
  end

  def destroy
    @playlist = Playlist.find(params[:id])
    if @playlist.destroy
      redirect_to admin_category_path(@playlist.category_id), notice: 'Playlist supprimé!'
    else
      redirect_to admin_category_path(@playlist.category_id), alert: 'Error'
    end
  end

  private

    def playlist_params
      params.require(:playlist).permit(:url, :category_id)
    end
end