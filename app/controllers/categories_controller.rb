class CategoriesController < ApplicationController

  def categories_items
    
    if stale? Video.order('created_at DESC').first

      categories_items = []
      Category.main_category.order('categories.created_at DESC').each do |category|
        items = category.top_videos
        videos_items = []
        items.each do |item|
          videos_items << [path_slug: "#{category.slug}/#{item.slug}", item: item]
        end

        categories_items << [
          name: category.name,
          slug: category.slug,
          items: videos_items,
          videos_count: category.subcategories_videos.count
        ]
      end

      respond_to do |format|
        format.json { render json: categories_items, root: false }
      end
    end
  end

  def show
    @category = Category.find(params[:id])
    @videos = @category.subcategories_videos.order('created_at DESC')

    if stale? @category.subcategories.order('created_at DESC').first

      respond_to do |format|
        format.html { redirect_to "/#/categories/#{@category.slug}" }
        format.json { render json: @videos, meta: { category_name: @category.name, subcategories_names: @category.subcategories.pluck(:name) } }
      end
    end
  end
end
