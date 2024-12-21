class CreateConnections < ActiveRecord::Migration[7.2]
  def change
    create_table :connections do |t|
      t.integer :follower_id
      t.integer :following_id
      t.datetime :unfollowed_at

      t.timestamps
    end
  end
end
