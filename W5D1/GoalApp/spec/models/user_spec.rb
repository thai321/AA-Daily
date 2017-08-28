# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:thai) { FactoryGirl.build(:thai) }

  describe "Validate" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should have_many(:goals) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe "#is_password?" do
    it "Check the given password is correct" do
      expect(thai.is_password?("password")).to be true
    end

    it "Check the given passowrd is incorrect" do
      expect(thai.is_password?("password1")).to be false
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
      expect(User.find_by_credentials('thai', 'password')).to eq(thai)
    end

    it "Return nil if user enter the wrong username or/and password" do
      thai.save!
      expect(User.find_by_credentials('thai1', 'password')).to eq(nil)
      expect(User.find_by_credentials('thai', 'password1')).to eq(nil)
      expect(User.find_by_credentials('thai1', 'password1')).to eq(nil)
    end
  end


end
