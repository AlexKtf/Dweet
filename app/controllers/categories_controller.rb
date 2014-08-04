class CategoriesController < ApplicationController

  def index
    categories = Category.select('id, name, updated_at').order('categories.created_at DESC')

    if stale? categories
      respond_to do |format|
        format.json { render json: categories, only: [:id, :name], root: false }
      end
    end
  end

  def categories_items
    
    if stale? Video.order('created_at DESC').first

      categories_items = {}
      Category.order('categories.created_at DESC').each do |category|
        categories_items.merge!(category.name => { items: category.videos.limit(6), videos_count: category.videos.count })
      end

      respond_to do |format|
        format.json { render json: categories_items, root: false }
      end
    end
  end

  def show
    @category = Category.find(params[:id])

    if stale? @category
      respond_to do |format|
        format.html { redirect_to "/#/categories/#{@category.id}" }
        format.json { render json: @category.videos.order('created_at DESC'), root: false }
      end
    end
  end
end
