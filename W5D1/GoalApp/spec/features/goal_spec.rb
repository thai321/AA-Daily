require 'spec_helper'
require 'rails_helper'

feature 'the Goal Create Form' do
  subject(:thai) { FactoryGirl.build(:thai) }

  scenario 'has a New Goal button' do
    sign_in_as(thai)
    expect(page).to have_link('New Goal')
  end

  feature 'signing up a user' do
    before(:each) do
      sign_in_as(thai)
      click_on 'New Goal'
    end

    scenario 'shows the form of Title, Description, Completed label ' do
      expect(page).to have_content 'New Goal'
      expect(page).to have_content 'Title'
      expect(page).to have_content 'Description'
      expect(page).to have_content 'Completed'
      expect(page).to have_content 'Yes'
      expect(page).to have_content 'No'

      expect(page).to have_button 'Create Goal'
      expect(current_path).to eq(new_goal_path)
    end
  end
end


feature 'the Goal creating process' do
  subject(:thai) { FactoryGirl.build(:thai) }

  before(:each) do
    go_into_goal_form(thai)
  end

  feature 'fail to create a goal' do
    scenario "Without title" do
      fill_in 'Description', with: "some description"
      click_button "Create Goal"

      expect(page).to have_content('New Goal')
    end

    scenario "Without Description" do
      fill_in 'Title', with: "some title"
      click_button "Create Goal"

      expect(page).to have_content('New Goal')
    end
  end

  feature 'successfully creating a goal' do
    scenario "Show Goal's title and description, with default public and Not Completed" do
      fill_in 'Title', with: 'Some title'
      fill_in 'Description', with: 'Some description'
      click_button "Create Goal"

      expect(page).to have_content('Some title')
      expect(page).to have_content('Some description')
      expect(page).to have_content('Public')
      expect(page).to have_content('Completed: No')
    end

    scenario "Show Goal's title and description, with private and Completed" do
      fill_in 'Title', with: 'Some title'
      fill_in 'Description', with: 'Some description'
      choose('goal_private')
      choose('goal_completed')
      click_button "Create Goal"

      expect(page).to have_content('Some title')
      expect(page).to have_content('Some description')
      expect(page).to have_content('Private')
      expect(page).to have_content('Completed: Yes')
    end
  end

end


feature 'the Goal Edit process' do
  subject(:thai) { FactoryGirl.build(:thai) }

  before(:each) do
     create_goal(thai)
     visit user_url(thai)
  end

  scenario 'has a Edit Goal button' do
    expect(page).to have_link('Edit')
  end


  scenario 'shows the form of Title, Description, Completed label ' do
    click_on 'Edit'
    expect(page).to have_content 'Title'
    expect(page).to have_content 'Description'
    expect(page).to have_content 'Completed'
    expect(page).to have_content 'Yes'
    expect(page).to have_content 'No'
  end

  feature 'successfully Editing a goal' do
    scenario "Show new updated Goal's title, description, private, completed" do
      click_on 'Edit'
      fill_in 'Title', with: 'Some title edit'
      fill_in 'Description', with: 'Some description edit'
      choose('goal_private')
      choose('goal_completed')

      click_button 'Update Goal'

      expect(page).to have_content('Some title edit')
      expect(page).to have_content('Some description edit')
      expect(page).to have_content('Private')
      expect(page).to have_content('Completed: Yes')

      expect(current_path).to eq user_path(thai)
    end
  end

end

feature 'the Goal Delete process' do
  subject(:thai) { FactoryGirl.build(:thai) }

  before(:each) do
     create_goal(thai)
     visit user_url(thai)
  end

  scenario 'has a Delete Goal button' do
    expect(page).to have_button 'Delete'
  end

  feature 'successfully Delete a goal' do
    scenario "Show new updated Goal's title and description" do
      click_button 'Delete'
      expect(page).to_not have_content 'Some title'
      expect(page).to_not have_content 'Some description'
      expect(current_path).to eq (user_path(thai))
    end
  end

end
