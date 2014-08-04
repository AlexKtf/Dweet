class Video < ActiveRecord::Base
  belongs_to :category

  scope :videos, ->() { where(is_playlist: false) }
  scope :playlists, ->() { where(is_playlist: true) }

  validates :url, presence: true

  before_create :check_and_prepare
  after_create :touch_category

  def touch_category
    category.touch
  end

  def as_json(options = {})
    super(include: [:category])
  end

  def check_and_prepare
    begin
      item = is_playlist ? Yt::Playlist.new(id: url) : Yt::Video.new(id: url)
      self.title = item.title
      self.image_preview_url = item.thumbnail_url(:medium)

      if is_playlist
        # TODO : Calculate playlist duration
        # self.duration = item.playlist_items.map(:video).map(:duration).reduce(:+)
        self.first_video_url = item.playlist_items.first.video_id
      else
        self.duration = item.duration
      end

    rescue Yt::Errors::NoItems
      false        
    end
  end

end
