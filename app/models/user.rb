class User < ApplicationRecord
  validates_presence_of :name
  has_many :sleeps, dependent: :delete_all
  has_many :connections

  # Allows association to view list of users who follow a given user i.e. user.followers
  has_many :follower_relationships, foreign_key: :following_id, class_name: "Connection"
  has_many :followers, through: :follower_relationships, source: :follower

  # Allows association to view list of users who follow a given user i.e. user.following
  has_many :following_relationships, foreign_key: :follower_id, class_name: "Connection"
  has_many :following, through: :following_relationships, source: :following
end
