class CreateSleepRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :sleep_records, id: :uuid do |t|
      t.uuid :user_id
      t.timestamptz :clock_in_time
      t.timestamptz :clock_out_time
      t.integer :duration_in_seconds

      t.timestamps

      t.foreign_key :users, column: :user_id
    end
  end
end
