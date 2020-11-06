require 'rails_helper'

RSpec.describe MentionsService, type: :model do
  describe '#mention_creator' do
    let!(:mention_user) { create(:user, username: 'test') }
    let!(:twit) { create(:twit, body: 'Hi @test') }
    let!(:no_mention_twit) { create(:twit, body: 'Hi test') }

    context "when twit does not have a mention" do
      it 'will return nil' do
        parsed_twit2 = MentionsService.mention_creator(no_mention_twit)
        expect(parsed_twit2).to eq(nil)
      end
    end
    

    context "when twit has a mention" do
      let!(:parsed_twit) { MentionsService.mention_creator(twit) }

      it "will fetch the mentioned username of user" do
        parsed_twit = MentionsService.mention_creator(twit)
        expect(parsed_twit[0]).to eq("test")
      end

      it "will create a new mention" do
        expect(Mention.first.twit_id).to  eq(twit.id)
        expect(Mention.first.user_id).to  eq(mention_user.id)
      end

    end
  
  end
end
