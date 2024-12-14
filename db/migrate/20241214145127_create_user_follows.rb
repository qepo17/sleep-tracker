class CreateUserFollows < ActiveRecord::Migration[8.0]
  def change
    create_table :user_follows, id: :uuid do |t|
      t.uuid :follower_id
      t.uuid :following_id

      t.timestamps

      t.foreign_key :users, column: :follower_id
      t.foreign_key :users, column: :following_id

      t.unique_constraint([:follower_id, :following_id], name: "unique_user_follows_on_follower_id_and_following_id")
    end
  end
end
