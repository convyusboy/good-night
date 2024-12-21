class Connection < ApplicationRecord
  scope :active, -> { where(unfollowed_at: nil) }
  belongs_to :follower, foreign_key: "follower_id", class_name: "User"
  belongs_to :following, foreign_key: "following_id", class_name: "User"
  validate :connection_cannot_connect_to_self
  validates :follower_id, uniqueness: { scope: :following_id, message: "Connection already exists for specific following id and follower id" }

  def connection_cannot_connect_to_self
    if follower_id == following_id
      errors.add(:base, "Can't self connect")
    end
  end

  def follow
    if unfollowed_at.nil?
      if id.nil?
        save
      else
        errors.add(:base, "User with id " + follower_id.to_s + " already followed user with id " + following_id.to_s)
        false
      end
    else
      update_attribute(:unfollowed_at, nil)
    end
  end

  def unfollow
    update_attribute(:unfollowed_at, Time.now)
  end
end
