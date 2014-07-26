class Video < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :category

  include YtItem

  scope :videos, ->() { where(is_playlist: false) }
  scope :playlists, ->() { where(is_playlist: true) }

  validates :url, presence: true

  before_create :check_and_prepare

  def as_json(options = {})
    super(include: [:category])
  end

end
