require 'spec_helper'

describe RelationshipsController do
  let(:guy) { create :user }
  let!(:group_of_guys) { create :group, gender: "male", seeking_gender: "female", users: [guy] }
  let!(:group_of_girls) { create :group, gender: "female", seeking_gender: "male" }

  before do
    request.session[:user_id] = guy.id
  end

  describe "#create" do

    context "group_of_guys like group_of_girls" do
      subject { post :create, group_id: group_of_guys.id, other_group_id: group_of_girls.id, group_action: "like" }

      it "likes the group_of_girls for the group_of_guys" do
        subject
        expect(group_of_guys.likes?(group_of_girls)).to eq(true)
      end

      it "redirects to root path" do
        expect(subject).to redirect_to root_path
      end
    end

    context "group_of_guys dislike group_of_girls" do
      subject { post :create, group_id: group_of_guys.id, other_group_id: group_of_girls.id, group_action: "dislike" }

      it "likes the group_of_girls for the group_of_guys" do
        subject
        expect(group_of_guys.likes?(group_of_girls)).to eq(false)
      end

      it "redirects to root path" do
        expect(subject).to redirect_to root_path
      end
    end
  end
end