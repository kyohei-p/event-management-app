class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    if @categories.present?
      render json: { status: 'success', message: "全てのカテゴリー情報を取得しました", categories: @categories }, status: 200
    else
      render json: { status: 'error', message: "全てのカテゴリー情報を取得できませんでした" }, status: 500
    end
  end
end