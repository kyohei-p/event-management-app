module GetEvents
  extend ActiveSupport::Concern

  included do
    def find_by_category(category_id: params[:category_id])
      Category.find_by(id: category_id)
    end

    def where_category_events(category_id: params[:category_id])
      Event.where(category_id: category_id).order(updated_at: "DESC").page(params[:page])
    end

    def where_eventday_events(event_day: params[:event_day])
      Event.where(event_day: event_day).order(updated_at: "DESC").page(params[:page])
    end

    def all_events
      Event.includes(:category).order(updated_at: "DESC").page(params[:page])
    end
  end
end
