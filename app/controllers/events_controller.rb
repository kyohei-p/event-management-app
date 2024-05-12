class EventsController < ApplicationController
  skip_before_action :require_login, only: [:index]
  before_action :require_login, only: [:create, :new, :manage_events]

  def index
    if params[:category_id]
      category_id = Category.find_by(id: params[:category_id])
      @events = Event.where(category_id: category_id, public_status: 1).order(updated_at: "DESC").page(params[:page])
    elsif params[:event_day]
      @events = Event.where(event_day: params[:event_day], public_status: 1).order(updated_at: "DESC").page(params[:page])
    else
      @events = Event.includes(:category).where(public_status: 1).order(updated_at: "DESC").page(params[:page])
    end
  end

  def create
    @event = Event.new(event_params)
    @event.category = Category.find_by(id: event_params[:category_id])
    @event.user = current_user
    if @event.save
      redirect_to(root_path, notice: 'イベントを作成しました')
    else
      flash.now[:alert] = 'イベントの作成に失敗しました'
      render action: 'new', status:400
    end
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    if @event.save
      redirect_to manage_events_path, notice: 'イベントを更新しました'
    else
      flash.now[:alert] = 'イベントの更新に失敗しました'
      render action: 'edit', status: 400
    end
  end


  def manage_events
    if params[:category_id]
      category_id = Category.find_by(id: params[:category_id])
      @manage_events = Event.where(user_id: current_user, category_id: category_id).order(updated_at: "DESC").page(params[:page])
    elsif params[:event_day]
      @manage_events = Event.where(user_id: current_user, event_day: params[:event_day]).order(updated_at: "DESC").page(params[:page])
    else
      @manage_events = Event.where(user_id: current_user).order(updated_at: "DESC").page(params[:page])
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :event_description, :event_day, :public_status, :image, :category_id)
  end
end
