class UserFollow < ApplicationRecord
  validates :follower_id, presence: true, uniqueness: { scope: :following_id }, on: :create
  validates :following_id, presence: true
end
