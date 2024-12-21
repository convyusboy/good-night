class Sleep < ApplicationRecord
  belongs_to :user
  scope :recents, -> { where("created_at > ?", 1.week.ago) }
  scope :finished, -> { where("duration > 0") }
  validates :user_id, presence: true
  validates :ended_at, comparison: { greater_than: :created_at }, on: :update
  validate :previous_sleep_should_have_been_ended, on: :create

  def previous_sleep_should_have_been_ended
    user = User.find(user_id)
    sleeps = user.sleeps
    if sleeps.count > 0 && sleeps.last&.ended_at.nil?
      puts self
      errors.add(:base, "Previous sleep should have been ended first before you sleep")
    end
  end

  def ongoing?
    ended_at.nil?
  end
end
