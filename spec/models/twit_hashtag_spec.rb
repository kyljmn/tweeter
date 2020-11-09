require "rails_helper"

RSpec.describe TwitHashtag, type: :model do
  context "when validating a twit_hashtag " do
    let!(:twit_hashtag) { create(:twit_hashtag) }
    let(:twit_hashtag_clone) { build(:twit_hashtag, hashtag_id: twit_hashtag.hashtag_id, twit_id: twit_hashtag.id) }

    it "is valid if its unique" do
      expect(twit_hashtag).to be_valid
    end

    it "is invalid if TwitHashtag already exist" do
      expect(twit_hashtag_clone).not_to be_valid
    end
  end
end
