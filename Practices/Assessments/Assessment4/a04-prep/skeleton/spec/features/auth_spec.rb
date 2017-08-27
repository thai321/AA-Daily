require 'rails_helper'

feature 'Sign up' do
  before :each do
    visit new_user_path
  end

  it 'has a user sign up page' do
    expect(page).to have_content 'Sign Up'
  end

  it 'takes a username and password' do
    expect(page).to have_content 'Username'
    expect(page).to have_content 'Password'
  end

  it 'redirects to links index and displays user\'s username on success' do
    sign_up_as_ginger_baker
    # add user name to application.html.erb layout
    expect(page).to have_content 'ginger_baker'
    expect(current_path).to eq(links_path)
  end
end

feature 'Sign out' do
  it 'has a sign out button' do
    sign_up_as_ginger_baker
    expect(page).to have_button 'Sign Out'
  end

  it 'after logout, user is redirected to login form' do
    sign_up_as_ginger_baker

    click_button 'Sign Out'

    # redirect to login page
    expect(current_path).to eq(new_session_path)
    expect(page).to have_content 'Sign In'
    expect(page).to have_content 'Username'
  end
end

feature 'Sign in' do
  it 'has a sign in page' do
    visit new_session_path
    expect(page).to have_content 'Sign In'
  end

  it 'takes a username and password' do
    visit new_session_path
    expect(page).to have_content 'Username'
    expect(page).to have_content 'Password'
  end

  it 'returns to sign in on failure' do
    visit new_session_path
    fill_in 'Username', with: 'ginger_baker'
    fill_in 'Password', with: 'hello'
    click_button 'Sign In'

    # return to sign-in page
    expect(page).to have_content 'Sign In'
    expect(page).to have_content 'Username'
  end

  it 'takes a user to links index on success' do
    User.create!(username: 'jack_bruce', password: 'abcdef')
    sign_in('jack_bruce')

    expect(page).to have_content 'jack_bruce'
    expect(current_path).to eq(links_path)
  end
end
