class ApplicationController < ActionController::Base
  before_action :require_login
  protect_from_forgery with: :exception

  protected

  def not_authenticated
    redirect_to login_url, alert: 'ログインしてください'
  end
end
