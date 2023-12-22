class Post < ApplicationRecord
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_users, through: :bookmarks, source: :user
  has_many :post_comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, source: :tag

  has_one_attached :image

  validates :store_name, presence:true, length: { maximum: 20 }
  validates :description, presence:true, length: {maximum:100}
  # validates :is_published, presence:true
  validates :address, presence:true, length: { minimum: 2, maximum: 50 }
  validates :image, presence: true

  # 指定したユーザーがいいねしているかの確認

  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end

  def self.bookmarked_post(user) # 1. モデル内での操作を開始
    includes(:bookmarks) # 2. post_favorites テーブルを結合
      .where(bookmarks: { user_id: user.id }) # 3. ユーザーがいいねしたレコードを絞り込み
      .order(created_at: :desc) # 4. 投稿を作成日時の降順でソート
  end

  # 新しいタグの保存
  def save_tag(sent_tags)
    self.transaction do
      # Retrieve current tags
      current_tags = self.tags.pluck(:name) unless self.tags.nil?

      # Calculate old and new tags
      old_tags = current_tags - sent_tags
      new_tags = sent_tags - current_tags

      # Delete old tags with a single query
      Tag.where(name: old_tags).destroy_all

      # Create or find new tags and associate them with the post
      new_tags.each do |new|
        new_post_tag = Tag.find_or_create_by(name: new)
        self.tags << new_post_tag
      end
    end
  end

  def self.valid_looks(search,word)
    if search == "perfect_match"
      @post = Post.where(is_published: true).where("store_name LIKE ?","#{word}")
    elsif search == "partial_match"
      @post = Post.where(is_published: true).where("store_name LIKE ?", "%#{word}%")
    end
  end

  def self.looks(search,word)
    if search == "perfect_match"
      @post = Post.where("store_name LIKE ?","#{word}")
    elsif search == "partial_match"
      @post = Post.where("store_name LIKE ?", "%#{word}%")
    end
  end

end
