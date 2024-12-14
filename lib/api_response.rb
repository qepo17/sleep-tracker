module ApiResponse
  extend ActiveSupport::Concern

  def error_response(body, status = 400)
    render json: { error: body }, status: status
  end

  def unauthorized_response
    render json: { error: "Please log in to access this resource" }, status: :unauthorized
  end

  def forbidden_response
    render json: { error: "You are not authorized to access this resource" }, status: :forbidden
  end

  def success_response(body, status = 200)
    render json: body, status: status
  end
end