class CategoriesController < ApplicationController

  def index
    if stale? Category.main_category.order('created_at DESC').first
      categories = Category.main_category.order('created_at DESC').select('id, name, updated_at')

      respond_to do |format|
        format.json { render json: categories, except: :videos_count, root: false }
      end
    end
  end

  def show
    @category = Category.find(params[:id])

    if stale? @category

      @videos = @category.all_videos.order('created_at DESC')

      respond_to do |format|
        format.html { redirect_to "/#/categories/#{@category.slug}" }
        format.json { render json: @videos, except: [:category_slug], meta: { category_name: @category.name, subcategories_names: @category.subcategories.pluck(:name) } }
      end
    end
  end
end
