class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :interests
  belongs_to :admin, class_name: "User"
  has_many :relationships, foreign_key: "liker_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "liked_id", class_name: "Relationship"
  has_many :likes, through: :relationships
  has_many :likers, through: :reverse_relationships
  has_many :group_invites
  belongs_to :location

  validates :name, :tagline, :gender, :seeking_gender, :location_id, :start_date, :end_date, presence: true
  validate :validate_trip_date, if: "start_date.present? && end_date.present?"

  attr_accessor :user_uids

  def admin?(user)
    user.id == admin.id
  end

  def like!(group)
    relationships.create!(liked_id: group.id, like: true)
  end

  def dislike!(group)
    relationships.create!(liked_id: group.id, like: false)
  end

  def likes?(group)
    relationships.where(liked_id: group.id, like: true).count == 1
  end

private

  def validate_trip_date
    errors.add(:trip_date, "is invalid") if 1.day.from_now > start_date || end_date < start_date
  end

end