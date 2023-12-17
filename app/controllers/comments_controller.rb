class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
    if broadcasting_to_current_user?
      return render plain: "", status: :no_content
    end

    @comment = Comment.find(params[:id])
    @post = @comment.post

    respond_to do |format|
      format.turbo_stream { render "comments/show" }
    end
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.commenter = current_user

    respond_to do |format|
      if @comment.save
        @post = @comment.post
        broadcast_to_all_clients
        format.turbo_stream { render "comments/create", locals: { comment: @comment, post: @comment.post } }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:content, :post_id, :commenter_id)
    end

    def broadcast_to_all_clients
      data = {
        op: "comment_created",
        comment: {
          id: @comment.id,
          content: @comment.content,
          created_at: @comment.created_at,
          post_id: @comment.post.id,
          author: {
            id: @comment.commenter.id,
            name: @comment.commenter.name,
          }
        }
      }

      ActionCable.server.broadcast("global_updates", data)
    end
end
