class AddCompositeIndexUserIdClockInTimeToSleepRecords < ActiveRecord::Migration[8.0]
  def change
    add_index :sleep_records, [:user_id, :clock_in_time], name: "index_sleep_records_on_user_id_and_clock_in_time"
  end
end
