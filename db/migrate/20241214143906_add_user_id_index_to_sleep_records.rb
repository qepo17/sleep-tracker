class AddUserIdIndexToSleepRecords < ActiveRecord::Migration[8.0]
  def change
    add_index :sleep_records, :user_id
  end
end
