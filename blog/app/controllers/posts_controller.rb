class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
  end

  def create
    # 1.
    Post.create(title: params[:title],
                body: params[:body])

    ## 1-1. past use
    #Post.create(:title => params[:title], :body => params[:body])
    #
    ## 2.
    #post = Post.new
    #post.title = params[:title]
    #post.body = params[:body]
    #post.save


  end
end
