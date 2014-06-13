class Admin::ArtistsController < Admin::BaseController

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      redirect_to admin_artist_path(@artist.id), notice: 'Success!'
    else
      redirect_to admin_dashboard_index_path, alert: 'Un nom est nécessaire'
    end
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def destroy
    @artist = Artist.find(params[:id])
    if @artist.destroy
      redirect_to admin_dashboard_index_path, notice: 'Artist supprimé!'
    else
      redirect_to admin_dashboard_index_path, alert: 'Error'
    end
  end

  private

    def artist_params
      params.require(:artist).permit(:name)
    end
end