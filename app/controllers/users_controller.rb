class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to(root_path, notice: 'ユーザーを登録しました')
    else
      flash.now[:alert] = 'ユーザーの登録に失敗しました'
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
