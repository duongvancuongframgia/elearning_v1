class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user

  scope :recent, ->{order created_at: :desc}
end