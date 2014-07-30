class Admin::DashboardController < Admin::BaseController

  def index
    @category = Category.new
    @artist = Artist.new
  end
end