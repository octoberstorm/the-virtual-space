class Admin::CommentsController < Admin::AdminController
  before_action :set_comment, only: %i[show edit update destroy]

  # GET /admin/comments
  def index
    @comments = Comment.all
  end

  # GET /admin/comments/1
  def show; end

  # GET /admin/comments/new
  def new
    @comment = Comment.new
  end

  # GET /admin/comments/1/edit
  def edit; end

  # POST /admin/comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to admin_comments_path, notice: 'Comment was successfully created.'
    else
      flash.now[:alert] = @comment.errors.full_messages.join(', ')
      render :new
    end
  end

  # PATCH/PUT /admin/comments/1
  def update
    if @comment.update(comment_params)
      redirect_to admin_comments_path, notice: 'Comment was successfully updated.'
    else
      flash.now[:alert] = @comment.errors.full_messages.join(', ')
      render :edit
    end
  end

  # DELETE /admin/comments/1
  def destroy
    @comment.destroy
    redirect_to admin_comments_path, notice: 'Comment was successfully destroyed.'
  end

  private

  def set_comment
    @comment ||= Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
