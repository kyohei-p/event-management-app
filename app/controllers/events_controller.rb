class EventsController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    @message = "イベントの一覧情報を表示します"
  end
end
