class DashboardController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc)
    @online_users = User.online
    @offline_users = User.offline
    @popular_posts = Post.popular_posts
  end
end
