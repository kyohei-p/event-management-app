class Event < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_one_attached :image

  enum public_status: { closed: 0, open: 1 }, _prefix: true

  validates :name, presence: true, length: { maximum: 50 }

  validates :event_description, length: { maximum: 255 }

  validates_associated :category
  validate :category_presence

  validates :event_day, presence: true

  validates :public_status, presence: true

  def category_presence
    errors.add(:category_id, "カテゴリーを選択してください。") if category_id.nil?
  end

end