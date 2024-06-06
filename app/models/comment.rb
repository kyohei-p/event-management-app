class Comment < ApplicationRecord
  include Discard::Model
  default_scope -> { kept }

  belongs_to :user, optional: true
  belongs_to :event

  validates :content, presence: true, length: { maximum: 255 }
end
