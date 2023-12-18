class Admin::PostsController < Admin::AdminController
  before_action :set_post, only: %i[show edit update destroy]

  # GET /admin/posts
  def index
    @posts = Post.paginate(page: params[:page], per_page: 5)
  end

  # GET /admin/posts/1
  def show; end

  # GET /admin/posts/new
  def new
    @post = Post.new
  end

  # GET /admin/posts/1/edit
  def edit; end

  # POST /admin/posts
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to admin_posts_path, notice: 'Post was successfully created.'
    else
      flash.now[:alert] = @post.errors.full_messages.join(', ')
      render :new
    end
  end

  # PATCH/PUT /admin/posts/1
  def update
    if @post.update(post_params)
      redirect_to admin_posts_path, notice: 'Post was successfully updated.'
    else
      flash.now[:alert] = @post.errors.full_messages.join(', ')
      render :edit
    end
  end

  # DELETE /admin/posts/1
  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: 'Post was successfully destroyed.'
  end

  private

  def set_post
    @post ||= Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :visibility)
  end
end
