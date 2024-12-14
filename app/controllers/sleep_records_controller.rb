class SleepRecordsController < ApplicationController
  def index
    current_user_id = session[:current_user_id]

    return unauthorized_response unless current_user_id

    sleep_records = SleepRecord.find_by(user_id: 1)

    return error_response("No sleep records found", 404) if sleep_records.nil? || sleep_records.empty?

    render success_response(sleep_records, :created)
  end
end