require 'rails_helper'

RSpec.describe Twit, type: :model do
  context "when validating a twit" do
    let(:valid_twit) { FactoryBot.create :twit }
  end
end
