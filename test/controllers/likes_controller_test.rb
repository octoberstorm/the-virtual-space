require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @post = posts(:one)
    @like = likes(:one)

    sign_in @user
  end

  test "should get create" do
    post post_likes_url(@post.id), xhr: true, params: { format: :turbo_stream }
    assert_response :success
  end

  test "should get destroy" do
    delete post_like_path(@post.id, @like.id), xhr: true, params: { format: :turbo_stream }
    assert_response :success
  end
end
