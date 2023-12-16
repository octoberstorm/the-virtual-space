require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @post = Post.new(content: "Hello, world!", visibility: "public", user: users(:one))
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "content should be present" do
    @post.content = ""
    assert_not @post.valid?
  end

  test "visibility should be present" do
    @post.visibility = ""
    assert_not @post.valid?
  end

  test "should belong to a user" do
    assert_instance_of User, @post.user
  end

  test "should have many likes" do
    assert_instance_of Like, @post.likes.build
  end

  test "should have many comments" do
    assert_instance_of Comment, @post.comments.build
  end
end
