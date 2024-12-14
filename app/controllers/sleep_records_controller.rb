class SleepRecordsController < ApplicationController
  def index
    current_user_id = session[:current_user_id]

    return unauthorized_response unless current_user_id

    sleep_records = SleepRecord.select("id, clock_in_time, clock_out_time, duration_in_seconds")
      .where(user_id: current_user_id)
      .order(clock_in_time: :desc)

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

  def clock_out
    current_user_id = session[:current_user_id]

    return unauthorized_response unless current_user_id

    id = params[:id]
    return error_response("Invalid sleep record id", 400) if id.nil? || id.empty?

    sleep_record = SleepRecord.find_by(id: id)
    return error_response("Sleep record not found", 404) if sleep_record.nil?

    return forbidden_response if sleep_record.user_id != current_user_id

    return error_response("You already clocked out", 400) unless sleep_record.clock_out_time.nil?
    
    clock_out_time = Time.now
    return error_response("You cannot clock out before clocking in", 400) if sleep_record.clock_in_time > clock_out_time
    
    sleep_record.clock_out_time = Time.now

    duration_in_seconds = sleep_record.clock_out_time - sleep_record.clock_in_time 
    sleep_record.duration_in_seconds = duration_in_seconds.to_i

    return error_response("Failed to create sleep record. Please contact support", 400) unless sleep_record.save
  
    success_response(sleep_record, :created)
  end

  private
  
  def sleep_record_params
    params.permit(:clock_in_time)
  end
end