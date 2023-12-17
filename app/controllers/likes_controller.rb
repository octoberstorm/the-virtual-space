class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)
    @like.save

    respond_to do |format|
      broadcast_to_all_clients
      format.turbo_stream { render :create }
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @post = Post.find(@like.likable_id)
    @like.destroy

    respond_to do |format|
      broadcast_to_all_clients
      format.turbo_stream { render :destroy }
    end
  end

  # for broadcasting to all clients
  def update_likes_count
    @post = Post.find(params[:post_id])
    respond_to do |format|
      format.turbo_stream { render :create }
    end
  end

  private

  def find_likable
    Post.find(params[:post_id])
  end

  def broadcast_to_all_clients
    data = {
      op: "like_count_update",
      post_id: @like.likable_id,
    }

    ActionCable.server.broadcast("global_updates", data)
  end
end
