class UserFollow < ApplicationRecord
  validates :follower_id, presence: true
  validates :following_id, presence: true
end
