require 'rails_helper'

RSpec.describe Mention, type: :model do
  context "when validating a Mention " do
   let!(:mention) { create(:mention) }
   let(:mention_clone) { build(:mention, user_id: mention.user_id, twit_id: mention.twit_id) }
  
   it "is valid if its unique" do
    expect(mention).to be_valid 
    end

    it "is invalid if mention already exist " do
      expect(mention_clone).not_to be_valid  
    end
  end
end
