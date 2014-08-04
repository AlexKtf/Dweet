class CategoriesController < ApplicationController

  def index
    categories = Category.order('categories.created_at DESC')
    # items = Video.all.order('created_at DESC')

    respond_to do |format|
      format.json { render json: categories }
    end
  end

  def categories_items
    categories_items = {}
    Category.order('categories.created_at DESC').each do |category|
      categories_items.deep_merge!({category.name => [category.videos.limit(6), category.videos.count]})
    end

    respond_to do |format|
      format.json { render json: categories_items }
    end
  end

  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: [@category.ordered_items, @category.name] }
    end
  end
end
