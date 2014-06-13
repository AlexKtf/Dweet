class Admin::DashboardController < Admin::BaseController

  def index
    flash.clear
    @category = Category.new
    @artist = Artist.new
  end
end