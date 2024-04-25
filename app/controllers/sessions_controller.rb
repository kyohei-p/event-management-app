class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_back_or_to(root_path, notice: 'ログインに成功しました')
    else
      flash.now[:alert] = 'メールアドレスかパスワードが正しくありません'
      render action: 'new'
    end
  end

  def new
    @user = User.new
  end

  def destroy
    logout
    redirect_to(login_path, notice: 'ログアウトしました')
  end
end
