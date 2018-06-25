class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
  end

  def create
    # get방식은 url에 정보가 나오기 떄문에 문제가 생김 & 글자에 길이제한이 있다.
    #post = Post.create(username: params[:username], title: params[:title], content: params[:content])
    Post.create(user_id: current_user.id, title: params[:title], content: params[:content])
    flash[:notice] = "글 작성이 완료되었습니다"
    #redirect_to "/posts/#{post.id}"
    redirect_to "/"
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    #post.update(username: params[:username], title: params[:title], content: params[:content])
    post.update(user_id: current_user.id, title: params[:title], content: params[:content])
    redirect_to "/posts/#{post.id}"
  end

  def destroy
    # get방식은 url 반복문으로 게시글을 다 지워버릴 수가 있다..
    Post.find(params[:id]).destroy
    redirect_to '/'
  end
end
