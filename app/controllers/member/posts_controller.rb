class Member::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    # 利用有効になっているユーザーで、そのユーザーの投稿で表示にしている投稿一覧を表示
    @posts = Post.includes(:user).where(users: { is_active: true }).where(is_published: true)
    @tag_list=Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
    @post_comments = @post.post_comments
    @post_tags = @post.tags

  end

  def destroy

  end

  def update
    @post = Post.find(params[:id])
    tag_list=params[:post][:name].split(',')
    if @post.update(post_params)
       @post.save_tag(tag_list)
      redirect_to post_path(@post), notice: "投稿を編集しました"
    else
       @user = @post.user
       @post_comment = PostComment.new
      render "show"
    end
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # postに紐づいているtagを配列で取り出す
    tag_list = params[:post][:name].split(',')
    # 住所から緯度経度に変換
    results = Geocoder.search(post_params[:address])
    # 緯度経度の変換結果があれば配列から変数に代入
    if results.present?
      coordinates = results.first.coordinates
      @post.latitude = coordinates[0]
      @post.longitude = coordinates[1]
    end

    if @post.save
      @post.save_tag(tag_list)
      @posts = Post.all
      redirect_to posts_path,notice:"投稿完了しました"
    else
      @user =current_user
      render "member/users/mypage"
    end
  end

  def search

    lat = params[:lat].to_f
    lng = params[:lng].to_f

    #数値の誤差を拾うように範囲指定(geocoderの変換精度を考慮)して該当レコードを持ってくる
    posts = Post.where("latitude BETWEEN #{lat} - 0.001 AND #{lat} + 0.001")
                .where("longitude BETWEEN #{lng} - 0.001 AND #{lng} + 0.001")

    @marker_arr =[]

    posts.each do |post|
      # 投稿画像をurlにしてjavascriptに渡す
      image_url = url_for(post.image) if post.image.attached?

      #pushメソッドで配列に値を入れる
       @marker_arr.push({
      user_name: post.user.name,
      store_name: post.store_name,
      description: post.description,
      latitude: post.latitude,
      longitude: post.longitude,
      address: post.address,
      image_url: image_url,
      # Add more attributes as needed
    })
      # @marker_arr.push(post)
    end
  end

  def search_tag

    #検索結果画面でもタグ一覧表示
    @tag_list=Tag.all
    #検索されたタグを受け取る
    @tag=Tag.find(params[:id])
    #検索されたタグに紐づく投稿を表示
    @posts=@tag.posts

  end


  private
  def post_params
    params.require(:post).permit(:store_name, :address, :description, :is_published, :image)
  end
end
