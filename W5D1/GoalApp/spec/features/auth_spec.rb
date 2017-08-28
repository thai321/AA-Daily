require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content 'New User'
  end

  feature 'signing up a user' do
    before(:each) do
      visit new_user_url
      fill_in 'User Name', with: "thai"
      fill_in 'Password', with: 'password'
      click_button "Create User"
    end

    scenario 'shows username on the homepage after signup' do
      expect(page).to have_content 'thai'
      expect(current_path).to eq(users_path)
    end
  end
end


feature 'logging in' do
  subject(:thai) { FactoryGirl.build(:thai) }

  scenario 'has a sign in page' do
    visit new_session_url
    expect(page).to have_content 'Sign In'
  end

  scenario "takes a username and password" do
    visit new_session_url
    expect(page).to have_content 'User Name'
    expect(page).to have_content 'Password'
  end


  scenario 'fail to logining with wrong username' do
    thai.save
    sign_in('thai1', 'password')

    expect(page).to have_content 'Sign In'
    expect(page).to have_content 'User Name'
    expect(page).to have_content 'Password'
  end

  scenario 'fail to logining with wrong password' do
    thai.save
    sign_in('thai', 'password1')

    expect(page).to have_content 'Sign In'
    expect(page).to have_content 'User Name'
    expect(page).to have_content 'Password'
  end

  scenario 'successfully logining with wrong username and password' do
    thai.save
    sign_in('thai1', 'password1')

    expect(page).to have_content 'Sign In'
    expect(page).to have_content 'User Name'
    expect(page).to have_content 'Password'
  end

  scenario 'successfully logining with correct username and password' do
    sign_in_as(thai)

    expect(current_path).to eq(users_path)
    expect(page).to have_content 'thai'
  end

  scenario 'shows username on the homepage after login successfully' do
    sign_in_as(thai)

    expect(current_path).to eq(users_path)
    expect(page).to have_content 'thai'
  end
end

feature 'logging out' do
  subject(:thai) { FactoryGirl.build(:thai) }
  before(:each) { sign_in_as(thai) }

  scenario 'has a sign out button' do
    expect(page).to have_button 'Sign Out'
  end

  scenario 'begins with a logged out state' do
    click_button 'Sign Out'

    expect(page).to have_content 'Sign In'
    expect(page).to have_content 'User Name'
    expect(page).to have_content 'Password'
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    click_button 'Sign Out'

    expect(page).to_not have_content 'thai'
  end
end
