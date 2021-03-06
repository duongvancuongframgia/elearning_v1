class UserCourse < ApplicationRecord

  belongs_to :user
  belongs_to :course

  scope :recent, ->{order created_at: :desc}
end
