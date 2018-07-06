class LikesController < ApplicationController
  before_action :authenticate_user!
  # def like
  #   if current_user.liked_posts.include? Post.find(params[:post_id])
  #     Like.find_by(user_id: current_user.id,
  #                   post_id: params[:post_id]).destroy
  #   else
  #     Like.create(user_id: current_user.id,
  #                 post_id: params[:post_id])
  #   end
  #   redirect_to '/'
  # end
  def create
    @like = Like.create(user_id: current_user.id,
                post_id: params[:post_id])
    @post_id = params[:post_id]
    respond_to do |format|
      format.html {redirect_to :back}
      format.js {}
    end

  end

  def destroy
    @post_id = params[:post_id]
    @like = Like.find_by(user_id: current_user.id,
                post_id: @post_id)
    @like.destroy
    respond_to do |format|
      format.html {redirect_to :back}
      format.js {}
    end
  end
end
