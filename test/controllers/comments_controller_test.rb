require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @comment = comments(:one)
    @post = @comment.post

    sign_in @user
  end

  test "should get index" do
    get comments_url
    assert_response :success
  end

  test "should create comment" do
    assert_difference("Comment.count") do
      post comments_url, params: { comment: { content: @comment.content, post_id: @comment.post_id } }, as: :turbo_stream
    end

    assert_response :success
  end

  test "should show comment" do
    get comment_url(@comment)
    assert_response :success
  end

  test "should update comment" do
    patch comment_url(@comment), params: { comment: { user_id: @comment.user_id, content: @comment.content, post_id: @comment.post_id } }
    assert_redirected_to comment_url(@comment)
  end

  test "should destroy comment" do
    assert_difference("Comment.count", -1) do
      delete comment_url(@comment)
    end

    assert_redirected_to comments_url
  end
end
