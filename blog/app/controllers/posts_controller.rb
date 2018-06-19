class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
  end

  def create
    # 1.
    post = Post.create(title: params[:title],
                body: params[:body])

    ## 1-1. past use
    #Post.create(:title => params[:title], :body => params[:body])
    #
    ## 2.
    #post = Post.new
    #post.title = params[:title]
    #post.body = params[:body]
    #post.save

    #flash message
    flash[:notice] = "글이 작성되었습니다."


    #text안에 변수를 넣을 때는 (textinterpolation)
    #반드시 ""으로 묶어야 한다
    redirect_to "/posts/#{post.id}"
  end

  #sinatra에서 없는. 게시물을 확인
  # variable routing
  def show
    @post = Post.find(params[:id])
  end
  #################################
  def destroy
    Post.find(params[:id]).destroy
    flash[:alert] = "글이 삭제되었습니다."
    redirect_to '/'
  end

  def edit
    @post = Post.find(params[:id])
  end
  def update
     #update 후에는 return문이 true/false가 된다.
      post = Post.find(params[:id])
      post.update(title: params[:title], body: params[:body])
      flash[:notice] = "글이 수정되었습니다."
      redirect_to "/posts/#{post.id}"
  end
end
