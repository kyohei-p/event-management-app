class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :regist_breadcrumb, only: [:new, :create]
  before_action :update_breadcrumb, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

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

  def update
    ApplicationRecord.transaction do
      @user.update(user_params)

      if params[:user][:delete_image] == 'true'
        @user.image.purge
      end

      if @user.save
        redirect_to(user_path(current_user), notice: 'ユーザー情報を更新しました')
      else
        flash.now[:alert] = 'ユーザー情報の更新に失敗しました'
        render action: 'edit'
      end
    end
  end

  def destroy
    @user.discard
    if @user.discarded?
      flash[:notice] = "退会しました"
      render json: { status: 'success', user_data: @user }, status: 200
    else
      flash.now[:alert] = '退会に失敗しました'
      render json: { status: 'error', message_type: 'alert', message: "退会に失敗しました" }, status: 400
    end
  end

  private

  def regist_breadcrumb
    add_breadcrumb 'ユーザー新規登録', new_user_path
  end

  def update_breadcrumb
    add_breadcrumb 'マイページ', user_path(current_user)
    add_breadcrumb 'ユーザー情報編集', edit_user_path
  end

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone_number, :self_introduction, :image, :delete_image)
  end
end
