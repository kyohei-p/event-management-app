class Event < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_one_attached :image

  enum public_status: { closed: 0, open: 1 }, _prefix: true

  #イベント名のバリデーション
  validates :name, presence: true, length: { maximum: 50 }

  #説明文のバリデーション
  validates :event_description, length: { maximum: 255 }

  #カテゴリー名のバリデーション
  validates_associated :category
  validate :category_presence

  #開催日のバリデーション
  validates :event_day, presence: true

  #公開状態のバリデーション
  validates :public_status, presence: true

  def category_presence
    errors.add(:category_id, "カテゴリーを選択してください。") if category_id.nil?
  end

end