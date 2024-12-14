class SleepRecordsController < ApplicationController
  def index
    current_user_id = session[:current_user_id]

    return render json: { error: "Not logged in" }, status: :unauthorized unless current_user_id

    sleep_records = SleepRecord.find_by(user_id: current_user_id)

    return render json: { error: "No sleep records found" }, status: :not_found if sleep_records.nil?

    render json: sleep_records
  end
end