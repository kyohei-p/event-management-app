class EventsController < ApplicationController
  skip_before_action :require_login, only: [:index]
  before_action :require_login, only: [:create, :new]

  def index
    @message = "イベントの一覧情報を表示します"
  end

  def create
    @event = Event.new(event_params)
    @event.category = Category.find_by(id: event_params[:category_id])
    @event.user = current_user
    if @event.save
      redirect_to(root_path, notice: 'イベントを作成しました')
    else
      render action: 'new', status:400
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
