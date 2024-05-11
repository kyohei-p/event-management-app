class EventsController < ApplicationController
  skip_before_action :require_login, only: [:index]
  before_action :require_login, only: [:create, :new, :manage_events]
  include GetEvents

  def index
    if params[:category_id]
      find_by_category
      @events = where_category_events
    elsif params[:event_day]
      @events = where_eventday_events
    else
      @events = all_events
    end
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

  def manage_events
    if params[:category_id]
      find_by_category
      @manage_events = where_category_events.where(user_id: current_user)
    elsif params[:event_day]
      @manage_events = where_eventday_events.where(user_id: current_user)
    else
      @manage_events = all_events.where(user_id: current_user)
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :event_description, :event_day, :public_status, :image, :category_id)
  end
end
