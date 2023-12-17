class Post < ApplicationRecord
  validates :content, presence: true
  validates :visibility, presence: true
  belongs_to :user
  has_many :likes, as: :likable, dependent: :destroy
  has_many :comments, dependent: :destroy

  class << self
    def popular_posts
      Post.all.sort_by { |post| post.comments.count }.reverse[0..4]
    end
  end
end
