class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def create
    ApplicationRecord.transaction do
      @user = User.new(user_params)

      if params[:user][:delete_image] == 'true'
        @user.image.purge
      end

      if @user.save
        session[:user_id] = @user.id
        redirect_to(root_path, notice: 'ユーザーを登録しました')
      else
        flash.now[:alert] = 'ユーザーの登録に失敗しました'
        render action: 'new'
      end
    end
  end

  def new
    @user = User.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :phone_number, :self_introduction, :image, :delete_image)
  end
end
