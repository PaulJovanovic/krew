require 'spec_helper'

describe Group do
  describe "#admin?" do
    let(:group_of_guys) { create :group }

    context "user is the admin" do
      let(:guy) { create :user }

      before do
        group_of_guys.users << guy
        group_of_guys.admin = guy
      end

      it "returns true" do
        expect(group_of_guys.admin?(guy)).to eq(true)
      end
    end

    context "user is not the admin" do
      let(:guy1) { create :user }
      let(:guy2) { create :user }

      before do
        group_of_guys.users << guy1
        group_of_guys.users << guy2
        group_of_guys.admin = guy1
      end

      it "returns true" do
        expect(group_of_guys.admin?(guy2)).to eq(false)
      end
    end
  end

  describe "#like!" do
    let(:group_of_guys) { create :group, gender: "male", seeking_gender: "female" }
    let(:group_of_girls) { create :group, gender: "female", seeking_gender: "male" }

    context "group_of_guys wants to bang the group_of_girls" do
      before do
        group_of_guys.like!(group_of_girls)
      end

      it "creates a relationship showing the guys liking the girls" do
        expect(Relationship.where(liker_id: group_of_guys.id, liked_id: group_of_girls.id, like: true).count).to eq(1)
      end

      context "group_of_girls has not acted upon group_of_guys yet" do
        it "does not create a reverse relationship" do
          expect(Relationship.where(liker_id: group_of_girls.id, liked_id: group_of_guys.id, like: true).count).to eq(0)
        end
      end
    end
  end

  describe "#dislike!" do
    let(:group_of_guys) { create :group, gender: "male", seeking_gender: "female" }
    let(:group_of_girls) { create :group, gender: "female", seeking_gender: "male" }

    context "group_of_girls do not want to bang group_of_guys" do
      before do
        group_of_girls.dislike!(group_of_guys)
      end

      it "creates a relationship showing the girls disliking the guys" do
        expect(Relationship.where(liker_id: group_of_girls.id, liked_id: group_of_guys.id, like: false).count).to eq(1)
      end
    end
  end

  describe "#likes?" do
    let(:group_of_guys) { create :group, gender: "male", seeking_gender: "female" }
    let(:group_of_girls) { create :group, gender: "female", seeking_gender: "male" }

    context "group_of_guys liked group_of_girls" do
      before do
        Relationship.create(liker_id: group_of_guys.id, liked_id: group_of_girls.id, like: true)
      end

      it "returns true" do
        expect(group_of_guys.likes?(group_of_girls)).to eq(true)
      end
    end

    context "group_of_guys has not acted upon group_of_girls" do
      before do
        Relationship.create(liker_id: group_of_guys.id, liked_id: group_of_girls.id, like: false)
      end

      it "returns false" do
        expect(group_of_guys.likes?(group_of_girls)).to eq(false)
      end
    end

    context "group_of_guys disliked group_of_girls" do
      before do
        Relationship.create(liker_id: group_of_guys.id, liked_id: group_of_girls.id, like: false)
      end

      it "returns false" do
        expect(group_of_guys.likes?(group_of_girls)).to eq(false)
      end
    end
  end
end