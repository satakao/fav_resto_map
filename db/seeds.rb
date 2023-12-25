# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "seedの実行を開始"
puts "ADMIN_EMAIL: #{ENV['ADMIN_EMAIL']}"
puts "ADMIN_PASSWORD: #{ENV['ADMIN_PASSWORD']}"

# 管理者側ログインデータ作成
Admin.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |admin|
  admin.password= ENV['ADMIN_PASSWORD']
end

names = ['satou', 'gotou']

# エンドユーザーのアカウントを作成
def find_or_create_user(name)

  email="#{name}@example.com"
  password="testtest1"
  is_active= true

  user = User.find_or_create_by!(email: email) do |u|
    u.name = name
    u.password = password
    u.is_active = is_active
  end

  # ユーザー情報が保存されたかの確認
  if user.persisted?
    puts "User created successfully: #{user.name}"
  else
    puts "Error creating user:"
    puts user.errors.full_messages
  end
end

 # 名前をnames配列から取り出しユーザー情報を作成
names.each_with_index do |name, index|
  find_or_create_user(name)
end

# タグの作成(tagsテーブル内にタグ名を作成)
tags = %w(焼肉 寿司)
tags.each { |tag_name| Tag.find_or_create_by(name: tag_name) }




# 投稿作成
def create_posts_for_user_with_ordered_dates(user, count, is_publishes_options, tags)
  # 日付の設定(現在の日付)
  initial_date = Time.now - (count - 1).days

  # 指定回数の投稿データを作成
  count.times do |i|
  # 各投稿のタイトル、本文、リンク、ステータス、タグを設定します。
    store_name = "お店#{i + 1}"
    description = "サンプルの投稿#{i + 1}。お店の説明文。"
    address = "東京都千代田区"
    is_published = is_publishes_options.sample
    tag_list = tags.sample(2) # ランダムなタグを2つ選択します。

    # 日付を順番に遅らせる。
    post_date = initial_date + i.days

    post_params = {
      store_name: store_name,
      user_id: user.id
    }

    # 投稿を作成または既存のものを検索
    post = Post.find_or_create_by!(post_params) do |p|
      p.store_name = store_name
      p.description = description
      p.address = address
      p.is_published = is_published
      p.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/curry.jpeg"), filename:"curry.jpeg")


     # p.tag_names = tags.sample(2)
    end
    # olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
    #   user.name = "Olivia"
    #   user.password = "password"
    #   user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
    # end


  tag_list.each do |tag_name|
    tag = Tag.find_or_create_by(name: tag_name)
    post.tags << tag
    puts "Tag names for post: #{tag_name}"
  end

    # わかりやすくするために作成した投稿情報をコンソールに表示するようにします。
    puts "Creating post with title: #{store_name}, user_name: #{user.name}, tag_list: #{tag_list}"
  end
end

# ユーザーごとに異なるステータス割り当て


User.where.not(name: 'guest').each do |user|
  is_publishes_options = [true] * 6 + [false] * 2
  create_posts_for_user_with_ordered_dates(user, 2, is_publishes_options, tags)
end


# 投稿へブックマークしたデータの作成
users = User.all
posts = Post.where(is_published: true)

users.each do |user|
  bookmarked_posts = posts.sample(rand(1..3))
  bookmarked_posts.each do |post|
    Bookmark.find_or_create_by!(
      user_id: user.id,
      post_id: post.id
    )
  end
end

user_comments = [
  '私も行きました。',
  '行ってみたいです。',
  '美味しそう！私も行ってみます。',
  'そこのお店私もよく行きます！',
]

users.each do |user|
  posts.each do |post|
    num_comments = rand(0..1)
    next if num_comments.zero?

    comment_text = user_comments.sample
    comment = PostComment.find_or_create_by!(
      user_id: user.id,
      post_id: post.id
    ) do |c|
      c.comment = comment_text
    end
  end
end

# リレーションシップの作成
users.each do |user|
  following_users = users - [user]
  following_users.shuffle.take(rand(1..4)).each do |following_user|
    Relationship.find_or_create_by!(
      follower_id: user.id,
      followed_id: following_user.id
    )
  end
end

puts "seedの実行が完了しました"