require 'spec_helper'
require 'rails_helper'

feature 'the Creating Goal Comment process' do
  subject(:thai) { FactoryGirl.build(:thai) }
  subject(:other) { FactoryGirl.build(:other) }

  before(:each) do
    create_goal(thai)
    click_button 'Sign Out'
    sign_in_as(other)
    visit goal_url(Goal.last)
  end

  scenario 'has a Add Goal Comment button' do
    expect(page).to have_button 'Add Goal Comment'
    expect(page).to have_content 'New Goal Comment'
  end

  scenario 'show the goal comment after adding it' do
    fill_in 'New Comment', with: 'Hello There goal comment'
    click_button 'Add Goal Comment'

    expect(page).to have_content 'Hello There goal comment'
    expect(current_path).to eq goal_path(Goal.last)
  end

end
