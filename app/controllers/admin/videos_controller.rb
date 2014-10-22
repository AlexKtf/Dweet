class Admin::VideosController < Admin::BaseController

  def create
    @video = Video.new(video_params)

    path = get_redirect_path(@video)

    if @video.save
      redirect_to path, notice: 'Success!'
    else
      redirect_to path, alert: 'Video est introuvable'
    end
  end

  def destroy
    @video = Video.find(params[:id])

    path = get_redirect_path(@video)

    if @video.destroy
      redirect_to path, notice: 'Video supprimé!'
    else
      redirect_to path, alert: 'Error'
    end
  end

  private

    def video_params
      params.require(:video).permit(:url, :is_playlist, :category_id)
    end

    def get_redirect_path video
      if video.category.main_category_id.nil?
        path = admin_category_path(id: video.category_id, common: true)
      else
        path = admin_category_path(video.category_id)
      end
    end
end