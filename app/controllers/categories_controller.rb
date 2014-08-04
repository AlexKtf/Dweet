class CategoriesController < ApplicationController

  def index
    categories = Category.order('categories.created_at DESC')

    if stale? categories
      respond_to do |format|
        format.json { render json: categories }
      end
    end
  end

  def categories_items
    if stale? Video.last
      categories_items = {}
      Category.order('categories.created_at DESC').each do |category|
        categories_items.deep_merge!({category.name => [category.videos.limit(6), category.videos.count]})
      end
      respond_to do |format|
        format.json { render json: categories_items }
      end
    end
  end

  def show
    @category = Category.find(params[:id])

    if stale? @category
      respond_to do |format|
        format.html { redirect_to root_path + "/#/categories/#{@category.id}" }
        format.json { render json: [@category.ordered_items, @category.name] }
      end
    end
  end
end
