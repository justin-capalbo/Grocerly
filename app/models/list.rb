class List < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy

  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 25 }
end
