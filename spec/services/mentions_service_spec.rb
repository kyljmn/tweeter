require 'rails_helper'

RSpec.describe MentionsService, type: :model do
  describe '#mention_creator' do
    let!(:mention_user) { create(:user, username: 'test') }
    let!(:twit) { create(:twit, body: 'Hi @test') }
    let!(:no_mention_twit) { create(:twit, body: 'Hi test') }

    it "will parse twit to look if there is a mentioned user" do
      parsed_twit = MentionsService.mention_creator(twit)
      parsed_twit2 = MentionsService.mention_creator(no_mention_twit)

      expect(parsed_twit[0]).to eq("test")
      expect(parsed_twit2).to eq(nil)
    end
    
    it "will create Mention if there is a mention in twit" do
      MentionsService.mention_creator(twit)

      expect(Mention.first.twit_id).to  eq(twit.id)
      expect(Mention.first.user_id).to  eq(mention_user.id)
    end
  
  end
end
