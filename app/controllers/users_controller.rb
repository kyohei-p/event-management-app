class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :regist_breadcrumb, only: [:new, :create]
  before_action :set_user, only: [:show, :edit]

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

  def show
    add_breadcrumb 'マイページ', user_path
  end

  def edit
  end

  private

  def regist_breadcrumb
    add_breadcrumb 'ユーザー新規登録', new_user_path
  end

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :phone_number, :self_introduction, :image, :delete_image)
  end
end
