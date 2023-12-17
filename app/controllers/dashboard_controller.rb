class DashboardController < ApplicationController
  def index
    if params[:search].presence
      @search = params[:search]
      @posts = Post.search(params[:search])
    else
      @posts = Post.order(created_at: :desc)
    end

    @online_users = User.online
    @offline_users = User.offline
    @popular_posts = Post.popular_posts
  end
end
