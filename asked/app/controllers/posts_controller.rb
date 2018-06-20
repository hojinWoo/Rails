class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
  end

  def create
    post = Post.create(username: params[:username], title: params[:title], content: params[:content])
    redirect_to "/posts/#{post.id}"
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(username: params[:username], title: params[:title], content: params[:content])
    redirect_to "/posts/#{post.id}"
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to '/'
  end
end
