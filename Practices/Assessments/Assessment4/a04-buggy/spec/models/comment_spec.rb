require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should validate_presence_of(:body) }
  it 'should validate that :user cannot be empty/falsy' do
    should validate_presence_of(:user).with_message(:required)
  end
  it 'should validate that :link cannot be empty/falsy' do
    should validate_presence_of(:link).with_message(:required)
  end
  it { should belong_to(:user) }
  it { should belong_to(:link) }
end
