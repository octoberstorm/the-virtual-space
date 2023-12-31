class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 50 }

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one :admin

  scope :online, -> { where('last_request_at > ?', 15.minutes.ago) }
  scope :offline, -> { where('last_request_at <= ?', 15.minutes.ago) }

  def likes?(likable)
    likable.likes.where(user_id: id).any?
  end
end
