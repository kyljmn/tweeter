require 'rails_helper'

RSpec.describe HashtagsService, type: :model do
  describe '#hashtag_creator' do
    let!(:twit) { create(:twit, body: 'this is a #test') }
    let!(:no_hashtag_twit) { create(:twit, body: 'this is a test') }
    let!(:hashtag) { create(:hashtag, name: "testing") }
    let!(:existing_hashtag) { create(:twit, body: "this is a ##{hashtag.name}") }
    it "will parse twit and look for a hashtag" do
      parsed_twit = HashtagsService.hashtag_creator(twit)
      parsed_twit2 = HashtagsService.hashtag_creator(no_hashtag_twit)

      expect(parsed_twit[0]).to eq("test")
      expect(parsed_twit2).to eq(nil)
    end

    context "when it has a hashtag" do
      it "will create a hashtag if hashtag doesn't exit and include in hashtags of twit" do
        HashtagsService.hashtag_creator(twit)
  
        expect(Hashtag.last.name).to eq("test")  
        expect(twit.hashtags.last).to eq(Hashtag.last)  
      end
  
      it "will include hashtag in hashtags of twit if it exist" do
        expect(Hashtag.last.name).to eq(hashtag.name)  

        HashtagsService.hashtag_creator(existing_hashtag)
        
        expect(existing_hashtag.hashtags.last).to eq(hashtag)  
      end
    end
    
  
  end
end
