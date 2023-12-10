class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  has_one_attached :image

  validates :store_name, presence:true
  validates :description, presence:true,length:{maximum:100}
  validates :is_published, presence:true
  validates :address, presence:true
  validates :image, presence: true

  # 指定したユーザーがいいねしているかの確認
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end
end
