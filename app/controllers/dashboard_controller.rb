class DashboardController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc)
    @online_users = User.online_users
  end
end
