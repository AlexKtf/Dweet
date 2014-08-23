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
    unless @category.main_category.nil?
      @subcategory = @category
      @category = @subcategory.main_category
      @playlists = @subcategory.videos.playlists
      @videos = @subcategory.videos.videos
    end

  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      path = @category.main_category.nil? ? admin_dashboard_index_path : admin_category_path(@category.main_category)
      redirect_to path, notice: 'Category supprimé!'
    else
      redirect_to admin_dashboard_index_path, alert: 'Error'
    end
  end

  private

    def category_params
      params.require(:category).permit(:name, :main_category_id)
    end
end