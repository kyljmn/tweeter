require "rails_helper"

RSpec.describe Hashtag, type: :model do
  context "when validating a hashtag " do
    let!(:hashtag) { create(:hashtag) }
    let(:blank_hashtag) { build(:hashtag, name: nil) }
    let(:clone_hashtag) { build(:hashtag, name: hashtag.name) }
    let(:invalid_hashtag) { build(:hashtag, name: "1" * 280) }

    it "is valid when all attributes are valid" do
      expect(hashtag).to be_valid
    end

    it "is invalid if name is blank" do
      expect(blank_hashtag).not_to be_valid
    end

    it "is invalid if name is already taken" do
      expect(clone_hashtag).not_to be_valid
    end

    it "is invalid if name has more than 279 characters" do
      expect(invalid_hashtag).not_to be_valid
    end
  end
end
