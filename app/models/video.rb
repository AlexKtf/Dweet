class Video < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :category

  enum style: [:of_the_week, :playlist]

  validates :url, presence: true

  before_create :url_is_valid?

  def url_is_valid?
    begin
      video = Yt::Video.new id: self.url
      self.title = video.title
      self.image_preview_url = video.thumbnail_url
    rescue Yt::Errors::NoItems
      false
    end
  end
end
