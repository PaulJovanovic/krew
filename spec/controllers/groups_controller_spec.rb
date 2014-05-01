require 'spec_helper'

describe GroupsController do
  let(:guy) { create :user }
  let(:guy1) { create :user }
  let(:guy2) { create :user }

  before do
    request.session[:user_id] = guy.id
  end

  describe "#create" do
    let(:location) { create :location, city: "Las Vegas" }
    let(:interest1) { create :interest, location: location, name: "interest1" }
    let(:interest2) { create :interest, location: location, name: "interest2" }
    let(:interest3) { create :interest, location: location, name: "interest3" }

    subject {
      post :create, group: {
        admin_id: guy.id,
        name: "Group Name",
        tagline: "Group Tagline",
        gender: guy.gender,
        seeking_gender: "female",
        location_id: location.id,
        start_date: "2051-12-25",
        end_date: "2051-12-31",
        interest_ids: [interest1.id.to_s, interest2.id.to_s, interest3.id.to_s],
        user_uids: [guy1.uid, guy2.uid]
      }
    }

    context "successful save" do
      it "adds the interests" do
        subject
        expect(assigns[:group].interests.include?(interest1)).to eq(true)
        expect(assigns[:group].interests.include?(interest2)).to eq(true)
        expect(assigns[:group].interests.include?(interest3)).to eq(true)
      end

      it "adds the person to the group" do
        subject
        expect(assigns[:group].users.include?(guy)).to eq(true)
      end

      it "creates group invites for each user uid entered" do
        subject
        user_ids = assigns[:group].group_invites.map(&:user_id)
        expect(user_ids.include?(guy1.id)).to eq(true)
        expect(user_ids.include?(guy2.id)).to eq(true)
      end

      it "sets admin to the person creating the group" do
        subject
        expect(assigns[:group].admin).to eq(guy)
      end

      it "redirects to group" do
        expect(subject).to redirect_to group_path(assigns[:group])
      end
    end
  end
end