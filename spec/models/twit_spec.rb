require 'rails_helper'

RSpec.describe Twit, type: :model do
  context "when validating a twit" do
    let!(:original1) { create(:twit) }
    let(:retweet) { create(:twit, body: original1.body, retwit_id: original1.id, owner_id: original1.user.id)}
    let(:valid_twit) { build(:twit) }
    let(:invalid_length) { build(:twit, body: '1' * 281) }
    let(:blank_body) { build(:twit, body: nil) }
    let(:invalid_image_count) { build(:twit, :too_many_images)}
    let(:invalid_image_size) { build(:twit, :six_mb_image)}
    let(:test_retweet) { build(:twit, body: retweet.body, user: retweet.user, retwit_id: original1.id, owner_id: original1.user.id)}
    it "is valid when all attributes are valid" do
      expect(valid_twit).to be_valid  
    end
      
    it "is invalid when body is greater than 280 characters" do
      expect(invalid_length).not_to be_valid  
    end

    it "is invalid when body is blank" do
      expect(blank_body).not_to be_valid  
    end

    it "is invalid if image count is greater than 4" do
      expect(invalid_image_count).not_to be_valid  
    end

    it "is invalid if image byte_size is greater than 5MB" do
      expect(invalid_image_size).not_to be_valid  
    end

    it "is invalid for a single user to retweet a post more than once" do
      expect(test_retweet).not_to be_valid  
    end
  end
end
