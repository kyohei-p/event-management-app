class Event < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_one_attached :image

  enum public_status: { 非公開: 0, 公開: 1 }, _prefix: true

  #イベント名のバリデーション
  validates :name, presence: true, length: { maximum: 50 }

  #説明文のバリデーション
  validates :event_description, length: { maximum: 255 }

  #開催日のバリデーション
  validates :event_day, presence: true

  #公開状態のバリデーション
  validates :public_status, presence: true

end