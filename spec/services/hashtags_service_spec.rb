require 'rails_helper'

RSpec.describe HashtagsService do
  describe '#hashtag_creator' do
    let(:twit) { create(:twit, body: 'this is a #test') }
    let!(:no_hashtag_twit) { create(:twit, body: 'this is a test') }
    let!(:hashtag) { create(:hashtag, name: "testing") }
    let!(:existing_hashtag) { create(:twit, body: "this is a ##{hashtag.name}") }

    context "when twit does not have a hashtag" do
      it "will return nill" do
        parsed_twit2 = HashtagsService.hashtag_creator(no_hashtag_twit)
        expect(parsed_twit2).to eq(nil)
      end
    end

    context "when it the twit has a hashtag" do
      it "will parse twit and look for a hashtag" do
        parsed_twit = HashtagsService.hashtag_creator(twit)
        expect(parsed_twit[0]).to eq("test")
      end

      context "when hashtag is new" do
        before { HashtagsService.hashtag_creator(twit) } 

        it "will create a new hashtag" do
          expect(Hashtag.last.name).to eq("test")  
        end

        it "will add new hashtag in hashtags of twit" do
          expect(twit.hashtags.last.name).to eq("test")  
        end
      end

      context "when hashtag alread exist" do
        before { HashtagsService.hashtag_creator(existing_hashtag) } 

        it "will verify that hashtag alreay exist" do
          expect(Hashtag.find(hashtag.id)).to eq(hashtag)
        end

        it "will add existing hashtag in hashtags of twit" do
          expect(existing_hashtag.hashtags.last).to eq(hashtag)  
        end
      end
    end 
  
  end
end
