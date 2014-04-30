class Relationship < ActiveRecord::Base
  belongs_to :liker, class_name: "Group"
  belongs_to :liked, class_name: "Group"
  validates :liker_id, presence: true
  validates :liked_id, presence: true
end
