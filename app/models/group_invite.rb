class GroupInvite < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  validates :user, :group, presence: true

  def accept!
    group.users << user
    self.delete
  end

  def decline!
    group.delete
  end
end