class PostsController < ApplicationController
  before_action :authorize, except: [:index]
  before_action :set_post, only: [:show, :edit, :destroy]

  def index
    @posts = Post.all
  end

  def new
  end

  def create
    # get방식은 url에 정보가 나오기 떄문에 문제가 생김 & 글자에 길이제한이 있다.
    #post = Post.create(username: params[:username], title: params[:title], content: params[:content])
    #Post.create(user_id: current_user.id, title: params[:title], content: params[:content])
    @post = current_user.posts.new(post_params)
    @post.save
    flash[:notice] = "글 작성이 완료되었습니다"
    #redirect_to "/posts/#{post.id}"
    redirect_to "/"
  end

  def show
    #@post = Post.find(params[:id])
  end

  def edit
    #@post = Post.find(params[:id])
  end

  def update
    #post = Post.find(params[:id])
    #post.update(username: params[:username], title: params[:title], content: params[:content])
    #@post.update(user_id: current_user.id, title: params[:title], content: params[:content])
    @post.update(post_params)
    redirect_to "/posts/#{post.id}"
  end

  def destroy
    # get방식은 url 반복문으로 게시글을 다 지워버릴 수가 있다..
    #Post.find(params[:id]).destroy
    @post.destroy
    redirect_to '/'
  end

  #private으로 만들면 Posts Controller에서만 활용 가능
  private
  # 따로 설정을 안해면 계속 돌기 때문
    def set_post
      @post = Post.find(params[:id])
    end

  #strong parameter

    def post_params
      # hash로 merge
      params.permit(:title, :content).merge(user_id: current_user.id)
    end

end
