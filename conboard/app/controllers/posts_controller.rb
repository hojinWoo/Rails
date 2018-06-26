class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.all
  end

  def new
    # form_for을 사용해서 rendering을 하기 위해 필요
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.save
    redirect_to "/"
  end

  def show
    @comments = @post.comments
  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to "/posts/#{@post.id}"
  end

  def destroy
    @post.destroy
    redirct_to "/"
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      #params.permit(:title, :content)

      # form_for로 hash안에 있는 것을 사용할 때 사용(이중 hash를 사용하기 때문)
      # @post가 비어있는 경우 create로 보내고, 값이 있는 경우 update로 보낸다.
      params.require(:post).permit(:title, :content)
    end
end
