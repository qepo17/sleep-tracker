class SessionsController < ApplicationController
  def create
    # Not best practice to use name as a login, but it's just for example
    user = User.find_by(name: params[:name])
    return error_response("Credentials invalid", 400) if user.nil?

    session[:current_user_id] = user.id

    success_response({ message: "Logged in successfully" }, 200)
  end
end
