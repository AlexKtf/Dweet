class CategoriesController < ApplicationController

  def index
    categories = Category.order('categories.created_at DESC')
    items = Video.all.order('created_at DESC')

    respond_to do |format|
      format.json { render json: [categories, items] }
    end
  end

  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @category.ordered_items }
    end
  end
end
