class CategoriesController < ApplicationController

  def index
    categories = Category.includes(:videos, :playlists).order('categories.created_at DESC')

    respond_to do |format|
      format.json { render json: categories, include: [:videos, :playlists] }
    end
  end

  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html
      format.json do
        render json: @category.ordered_items
      end
    end
  end
end
