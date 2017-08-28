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
      click_on "Create User"
    end

    scenario 'shows username on the homepage after signup' do
      expect(page).to have_content 'thai'
      expect(current_path).to eq(users_path)
    end
  end
end


feature 'logging in' do
  scenario 'shows username on the homepage after login' do
    
  end

end

feature 'logging out' do
  scenario 'begins with a logged otu state'

  scenario 'doesn\'t show username on the homepage after logout'


end
