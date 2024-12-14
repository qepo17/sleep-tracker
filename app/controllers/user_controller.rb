class UserController < ApplicationController
  def follow
    current_user_id = session[:current_user_id]
    return unauthorized_response unless current_user_id

    following_id = params[:user_id]
    return error_response("Invalid user id", 400) if following_id.nil? || following_id.empty?

    user_follow = UserFollow.new()
    user_follow.follower_id = current_user_id
    user_follow.following_id = following_id

    unless user_follow.save
      if user_follow.errors { |error| error.type == :uniqueness }
        return error_response("User already followed", 400)
      end

      return error_response("Failed to follow user. Please contact support", 500)
    end
  
    success_response(user_follow, :created)
  end

  def unfollow
    current_user_id = session[:current_user_id]
    return unauthorized_response unless current_user_id

    following_id = params[:user_id]
    return error_response("Invalid user id", 400) if following_id.nil? || following_id.empty?

    user_follow = UserFollow.find_by(follower_id: current_user_id, following_id: following_id)
    return error_response("User not followed", 400) if user_follow.nil?

    user_follow.destroy
    success_response(user_follow, :ok)
  end
end
