class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)
    @like.save

    respond_to do |format|
      format.turbo_stream { render :create }
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @post = @like.likable
    @like.destroy

    respond_to do |format|
      format.turbo_stream { render :destroy }
    end
  end

  private

  def find_likable
    Post.find(params[:post_id])
  end
end
