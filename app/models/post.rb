class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  has_one_attached :image

  validates :store_name, presence:true
  validates :description, presence:true,length:{maximum:100}
  # validates :is_published, presence:true
  validates :address, presence:true
  validates :image, presence: true

  # 指定したユーザーがいいねしているかの確認
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end

  def self.bookmarked_posts(user) # 1. モデル内での操作を開始
    includes(:bookmarks) # 2. post_favorites テーブルを結合
      .where(bookmarks: { user_id: user.id }) # 3. ユーザーがいいねしたレコードを絞り込み
      .order(created_at: :desc) # 4. 投稿を作成日時の降順でソート
  end

  def self.looks(search,word)
    if search == "perfect_match"
      @post = Post.where("store_name LIKE ?","#{word}")
    elsif search == "partial_match"
      @post = Post.where("store_name LIKE ?", "%#{word}%")
    end
  end

end
