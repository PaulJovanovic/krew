require 'spec_helper'

describe GroupInvite do
  let(:user) { create :user }
  let(:group) { create :group }
  let(:group_invite) { create :group_invite, group: group, user: user }

  describe "#accept!" do
    it "adds the user to the group" do
      group_invite.accept!
      expect(group.users.include?(user)).to eq(true)
    end

    it "deletes the group invite" do
      group_invite.expects(:delete).once
      group_invite.accept!
    end
  end

  describe "decline!" do
    it "deletes the group invite" do
      group_invite.expects(:delete).once
      group_invite.decline!
    end
  end
end