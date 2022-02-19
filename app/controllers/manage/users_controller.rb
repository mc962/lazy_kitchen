class Manage::UsersController < Manage::ApplicationController
  def index
    authorize!

    @users = User.page(params[:page])

    render :index
  end

  def show
    @user = current_user
    authorize! @user

    render :show
  end

  def destroy
    @user = User.friendly.find(params[:id])
    authorize! @user

    User.destroy(@user.id)

    redirect_to manage_users_path
  end
end
