class Playlist < ActiveRecord::Base

  belongs_to :category
  has_many :videos, dependent: :destroy

  enum state: [:inactive, :in_progress, :active]

  validates :url, :category_id, presence: true
  before_create :url_is_valid?
  after_create :sync_playlist

  private

    def url_is_valid?
      begin
        list = Yt::Playlist.new id: self.url
        self.title = list.title
        self.image_preview_url = list.thumbnail_url(:medium)
        self.state = 1
      rescue Yt::Errors::NoItems
        false        
      end
    end

    def sync_playlist
      list = Yt::Playlist.new id: self.url
      list.playlist_items.each do |video|
        # For some videos that have been deleted on Youtube
        begin
          self.videos.create!(url: video.video_id, title: video.title, image_preview_url: video.thumbnail_url, style: 1)
        rescue
          nil
        end
      end
      self.update_attributes!(state: 2)
    end
    handle_asynchronously :sync_playlist
end