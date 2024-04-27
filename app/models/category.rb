class Category < ApplicationRecord
  has_many :events

  #カテゴリー名のバリデーション
  validates :name, presence: true
end