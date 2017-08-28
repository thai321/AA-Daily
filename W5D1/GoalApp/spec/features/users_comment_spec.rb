require 'spec_helper'
require 'rails_helper'

feature 'the Creating User process' do
  subject(:thai) { FactoryGirl.build(:thai) }
  subject(:other) { FactoryGirl.build(:other) }

  before(:each) do
    other.save
    sign_in_as(thai)
    visit user_url(other)
  end

  scenario 'has a Add Comment button' do
    expect(page).to have_button 'Add Comment'
    expect(page).to have_content 'New Comment'
  end

  scenario 'show the comment after adding it' do
    fill_in 'New Comment', with: 'Hello There'
    click_button 'Add Comment'

    expect(page).to have_content 'Hello There'
  end

end
