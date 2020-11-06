require "rails_helper"

RSpec.describe Follow, type: :model do
  context "when validating a Mention " do
    let!(:follow) { create(:follow) }
    let(:follow_clone) { build(:follow, follower_id: follow.follower_id, following_id: follow.following_id) }

    it "is valid if its unique" do
      expect(follow).to be_valid
    end

    it "is invalid if user is already followed" do
      expect(follow_clone).not_to be_valid
    end
  end
end
