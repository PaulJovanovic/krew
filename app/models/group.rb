class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :admin, class_name: "User"
  has_many :relationships, foreign_key: "liker_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "liked_id", class_name: "Relationship"
  has_many :likes, through: :relationships
  has_many :likers, through: :reverse_relationships
  belongs_to :location

  has_and_belongs_to_many :interests

  validates :name, :gender, :seeking_gender, :location_id, :start_date, :end_date, presence: true

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
end