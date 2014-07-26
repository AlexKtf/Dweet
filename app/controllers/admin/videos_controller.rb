class Admin::VideosController < Admin::BaseController

  def create
    @video = Video.new(video_params)
    if @video.save
      redirect_to admin_category_path(@video.category_id), notice: 'Success!'
    else
      redirect_to admin_category_path(@video.category_id), alert: 'Video est introuvable'
    end
  end

  def destroy
    @video = Video.find(params[:id])
    if @video.destroy
      redirect_to admin_category_path(@video.category_id), notice: 'Video supprimé!'
    else
      redirect_to admin_category_path(@video.category_id), alert: 'Error'
    end
  end

  private

    def video_params
      params.require(:video).permit(:url, :is_playlist, :category_id)
    end
end