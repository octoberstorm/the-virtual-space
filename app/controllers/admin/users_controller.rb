class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /admin/users
  def index
    @users = User.all
  end

  # GET /admin/users/1
  def show; end

  # GET /admin/users/new
  def new
    @user = User.new
  end

  # GET /admin/users/1/edit
  def edit; end

  # POST /admin/users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: 'User was successfully created.'
    else
      flash.now[:alert] = @user.errors.full_messages.join(', ')
      render :new
    end
  end

  # PATCH/PUT /admin/users/1
  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User was successfully updated.'
    else
      flash.now[:alert] = @user.errors.full_messages.join(', ')
      render :edit
    end
  end

  # DELETE /admin/users/1
  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'User was successfully destroyed.'
  end

  private

  def set_user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :admin,
      :password,
      :password_confirmation
    )
  end
end
