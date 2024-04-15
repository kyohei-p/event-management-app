class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to(root_path, notice: 'ユーザーを作成しました')
    else
      render action: 'new'
    end
  end

  def new
    @user = User.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :phone_number, :self_introduction, :image)
  end
end
