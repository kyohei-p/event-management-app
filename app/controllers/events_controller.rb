class EventsController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    @message = "イベントの一覧情報を表示します"
  end

  def create
    if logged_in?
      @event = Event.new(event_params)
      @event.category_id = params[:event][:category_id]
      @event.user = current_user
      if @event.save
        redirect_to(root_path, notice: 'イベントを作成しました')
      else
        render action: 'new'
      end
    else
      redirect_to new_user_path
    end
  end

  def new
    @event = Event.new
  end

  private

  def event_params
    params.require(:event).permit(:name, :event_description, :event_day, :public_status, :image, :category_id)
  end
end
