class EventsController < ApplicationController
  skip_before_action :require_login, only: [:index]
  before_action :require_login, only: [:create, :new, :manage_events]
  before_action :set_event, only: [:edit, :update, :destroy]
  before_action :event_create_breadcrumb, only: [:new, :create]
  before_action :event_update_breadcrumb, only: [:edit, :update]

  def index
    if params[:category_id]
      @category = Category.find_by(id: params[:category_id])
      @events = Event.where(category_id: @category, public_status: 1).order(updated_at: "DESC").page(params[:page])
      add_breadcrumb 'イベント一覧', events_path
      add_breadcrumb "カテゴリ > #{@category.name}", category_events_path(category_id: @category.id)
    elsif params[:event_day]
      @events = Event.where(event_day: params[:event_day], public_status: 1).order(updated_at: "DESC").page(params[:page])
      add_breadcrumb 'イベント一覧', events_path
      add_breadcrumb "開催日 > #{params[:event_day]}", date_events_path(event_day: params[:event_day])
    else
      @events = Event.includes(:category).where(public_status: 1).order(updated_at: "DESC").page(params[:page])
      add_breadcrumb 'イベント一覧', events_path
    end
  end

  def create
    ApplicationRecord.transaction do
      @event = Event.new(event_params)
      @event.category = Category.find_by(id: event_params[:category_id])
      @event.user = current_user

      if params[:event][:delete_image] == 'true'
        @event.image.purge
      end

      if @event.save
        if params[:event][:public_status] == 'open'
          redirect_to(root_path, notice: 'イベントを作成しました')
        else
          redirect_to(root_path, notice: '非公開イベントを作成しました')
        end
      else
        flash.now[:alert] = 'イベントの作成に失敗しました'
        render action: 'new', status:400
      end
    end
  end

  def new
    @event = Event.new
  end

  def edit
    set_event
  end

  def update
    ApplicationRecord.transaction do
      @event.update(event_params)

      if params[:event][:delete_image] == 'true'
        @event.image.purge
      end

      if @event.save
        if params[:event][:public_status] == 'open'
          redirect_to(manage_events_path, notice: 'イベントを更新しました')
        else
          redirect_to(manage_events_path, notice: '非公開イベントを更新しました')
        end
      else
        flash.now[:alert] = 'イベントの更新に失敗しました'
        render action: 'edit', status: 400
      end
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
    if params[:id].present?
      @event.discard
      flash[:notice] = 'イベントを削除しました'
      render json: { status: 'success', event_name: @event.name }, status: 204
    else
      flash[:alert] = 'イベントの削除に失敗しました'
      render json: { status: 'error', message: "イベントを削除できませんでした" }, status: 400
    end
  end


  def manage_events
    if params[:category_id]
      @category = Category.find_by(id: params[:category_id])
      @manage_events = Event.where(user_id: current_user, category_id: @category.id).order(updated_at: "DESC").page(params[:page])
      add_breadcrumb 'イベント管理', manage_events_path
      add_breadcrumb "カテゴリ > #{@category.name}", manage_category_events_path(category_id: @category.id)
    elsif params[:event_day]
      @manage_events = Event.where(user_id: current_user, event_day: params[:event_day]).order(updated_at: "DESC").page(params[:page])
      add_breadcrumb 'イベント管理', manage_events_path
      add_breadcrumb "開催日 > #{params[:event_day]}", manage_date_events_path(event_day: params[:event_day])
    else
      @manage_events = Event.where(user_id: current_user).order(updated_at: "DESC").page(params[:page])
      add_breadcrumb 'イベント管理', manage_events_path
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_create_breadcrumb
    add_breadcrumb 'イベント管理', manage_events_path
    add_breadcrumb 'イベント作成', new_event_path
  end

  def event_update_breadcrumb
    add_breadcrumb 'イベント管理', manage_events_path
    add_breadcrumb 'イベント編集', edit_event_path
  end

  def event_params
    params.require(:event).permit(:name, :event_description, :event_day, :public_status, :image, :category_id, :delete_image)
  end
end
