class Post < ApplicationRecord
  validates :content, presence: true
  validates :visibility, presence: true
  belongs_to :user
  has_many :likes, as: :likable, dependent: :destroy
end
