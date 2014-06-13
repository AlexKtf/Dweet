class Admin::CategoriesController < Admin::BaseController

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_category_path(@category.id), notice: 'Success!'
    else
      redirect_to admin_dashboard_index_path, alert: 'Un nom est nécessaire'
    end
  end

  def show
    @category = Category.find(params[:id])
    @playlist = Playlist.new
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to admin_dashboard_index_path, notice: 'Category supprimé!'
    else
      redirect_to admin_dashboard_index_path, alert: 'Error'
    end
  end

  private

    def category_params
      params.require(:category).permit(:name)
    end
end