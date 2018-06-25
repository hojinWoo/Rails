class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :destroy]

  def index
    @posts = Post.all
  end

  def new
  end

  def create
    @post = Post.create(post_params)
    flash[:notice] = "글 작성이 완료되었습니다"
    redirect_to '/'
  end

  def show
    @comments = @post.comments
  end

  def edit
  end

  def update
    @post.update(post_params)
  end

  def destroy
    @post.destroy
    redirect_to '/'
  end

  private
  #action으로 사용 불가능

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.permit(:title, :content)
    end
end
