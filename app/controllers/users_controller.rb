class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      flash[:notice] = "不正なアクセスです"
      redireft_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :email, :user_image, :user_introduction)
  end
end
