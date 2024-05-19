class ApplicationController < ActionController::Base
  before_action :require_login
  protect_from_forgery with: :exception
  add_breadcrumb 'Top <i class="fa fa-home" aria-hidden="true"></i>'.html_safe, '/'

  protected

  def not_authenticated
    redirect_to login_url, alert: 'ログインしてください'
  end
end
