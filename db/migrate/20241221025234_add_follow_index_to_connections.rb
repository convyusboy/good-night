class AddFollowIndexToConnections < ActiveRecord::Migration[7.2]
  def change
    add_index :connections, [ :follower_id, :following_id ], unique: true
  end
end
