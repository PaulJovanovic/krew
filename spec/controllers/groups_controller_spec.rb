require 'spec_helper'

describe GroupsController do
  let(:guy) { create :user }

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
        gender: guy.gender,
        seeking_gender: "female",
        location_id: location.id,
        start_date: "51-12-25",
        end_date: "51-12-31",
        interest_ids: [interest1.id.to_s, interest2.id.to_s, interest3.id.to_s]
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

      it "sets admin to the person creating the group" do
        subject
        expect(assigns[:group].admin).to eq(guy)
      end

      it "redirects to group" do
        expect(subject).to redirect_to group_path(guy.groups.last)
      end
    end
  end
end