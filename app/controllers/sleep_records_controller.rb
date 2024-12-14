class SleepRecordsController < ApplicationController
  def index
    current_user_id = session[:current_user_id]

    return unauthorized_response unless current_user_id

    sleep_records = SleepRecord.where(user_id: current_user_id).order(created_at: :desc)

    return error_response("No sleep records found", 404) if sleep_records.nil? || sleep_records.empty?

    success_response(sleep_records, :created)
  end

  def clock_in
    current_user_id = session[:current_user_id]

    return unauthorized_response unless current_user_id

    sleep_record = SleepRecord.new(sleep_record_params)
    sleep_record.user_id = current_user_id

    return error_response("Failed to create sleep record. Please contact support", 400) unless sleep_record.save
  
    success_response(sleep_record, :created)
  end

  private
  
  def sleep_record_params
    params.permit(:clock_in_time)
  end
end