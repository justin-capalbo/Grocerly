class Item < ApplicationRecord
  belongs_to :list
  default_scope -> { order(created_at: :desc) }
  validates :list_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :notes, length: { maximum: 255 }
end
