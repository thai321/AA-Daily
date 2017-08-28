
RSpec.configure do |config|

  config.expect_with :rspec do |expectations|

    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end


  config.mock_with :rspec do |mocks|

    mocks.verify_partial_doubles = true
  end


  config.shared_context_metadata_behavior = :apply_to_host_groups
end

def sign_in(name, password)
  visit new_session_url
  fill_in 'User Name', with: name
  fill_in 'Password', with: password
  click_button 'Sign In'
end

def sign_in_as(user)
  user.save
  visit new_session_url
  fill_in 'User Name', with: user.username
  fill_in 'Password', with: user.password
  click_button 'Sign In'
end

def go_into_goal_form(user)
  sign_in_as(user)
  click_on 'New Goal'
end

def create_goal(user)
  go_into_goal_form(user)

  fill_in 'Title', with: 'Some title'
  fill_in 'Description', with: 'Some description'
  click_button "Create Goal"
end
