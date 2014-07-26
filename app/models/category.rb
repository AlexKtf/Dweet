class Category < ActiveRecord::Base

  has_many :videos, dependent: :destroy

  validates :name, presence: true

  def ordered_items
    videos.order('created_at DESC')
  end
end
