require "rails_helper"

RSpec.describe User, type: :model do
  context "when validating a user" do
    let!(:user1) { create :user }
    let(:taken_username) { build :user, username: user1.username }
    let(:taken_email) { build :user, email: user1.email }
    let(:blank_first_name) { build :user, first_name: "" }
    let(:short_first_name) { build :user, first_name: "a" }
    let(:blank_last_name) { build :user, last_name: "" }
    let(:short_last_name) { build :user, last_name: "a" }
    let(:blank_password) { build :user, password: "" }

    it "is valid with valid attributes" do
      expect(user1).to be_valid
    end

    it "isn't valid when username is already taken" do
      expect(taken_username).not_to be_valid
    end

    it "isn't valid when email is already taken" do
      expect(taken_email).not_to be_valid
    end

    it "isn't valid when first_name is blank" do
      expect(blank_first_name).not_to be_valid
    end

    it "isn't valid when first_name is less than 2 characters" do
      expect(short_first_name).not_to be_valid
    end

    it "isn't valid when last_name is blank" do
      expect(blank_last_name).not_to be_valid
    end

    it "isn't valid when last_name is less than 2 characters" do
      expect(short_last_name).not_to be_valid
    end

    it "isn't valid when password is blank" do
      expect(blank_password).not_to be_valid
    end
  end
end
