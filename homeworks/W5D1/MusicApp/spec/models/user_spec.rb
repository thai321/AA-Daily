require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:thai) { FactoryGirl.build(:thai) }

  describe "Validation"  do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe "#it_password?" do
    it "Check the given password is correct" do
      expect(thai.is_password?("password")).to be true
    end

    it "Check the given password is incorrect" do
      expect(thai.is_password?("somethingelse")).to be false
    end
  end

  describe "#reset_session_token!" do
    it "Generate a new session token" do
      old_token = thai.session_token
      thai.reset_session_token!
      expect(thai.session_token).to_not eq(old_token)
    end

    it "Return a new session token same as session_token" do
      expect(thai.reset_session_token!).to eq(thai.session_token)
    end
  end

  describe "::find_by_credentials" do
    it "Return the right user" do
      thai.save!
      expect(User.find_by_credentials('thai@example.com', 'password')).to eq(thai)
    end

    it "Return nil if user enter the wrong email or/and password" do
      thai.save!

      expect(User.find_by_credentials('thai1@example.com', 'password')).to eq(nil)
      expect(User.find_by_credentials('thai@example.com', 'password1')).to eq(nil)
      expect(User.find_by_credentials('thai1@example.com', 'password1')).to eq(nil)
    end
  end



end
