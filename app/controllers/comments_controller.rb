class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.event = Event.find(params[:event_id])
    @comment.user = current_user

    if @comment.save
      render json: { status: 'success', message_type: 'notice', message: "コメントを投稿しました", comment_data: @comment }, status: 200
    else
      render json: { status: 'error', message_type: 'alert', message: "コメントを投稿できませんでした", errors: @comment.errors.full_messages }, status: 422
    end
  end

  def new
    @comment = Comment.new
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :event_id, :user_id)
  end
end
