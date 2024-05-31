class CommentsController < ApplicationController
  skip_before_action :require_login, only: [:create]

  def create
    @comment = Comment.new(comment_params)
    @comment.event = Event.find(params[:event_id])
    if current_user
      @comment.user = current_user
      image_url = Rails.application.routes.url_helpers.rails_blob_path(current_user.image, only_path: true)
    else
      @comment.user = nil
      image_url = nil
    end

    if @comment.save
      render json: { status: 'success', message_type: 'notice', message: "コメントを投稿しました", comment_data: @comment, user_data: @comment.user, image_url: image_url }, status: 200
    else
      render json: { status: 'error', message_type: 'alert', message: "コメントを投稿できませんでした", errors: @comment.errors.full_messages }, status: 422
    end
  end

  def new
    @comment = Comment.new
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :event_id)
  end
end
