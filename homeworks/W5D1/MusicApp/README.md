# Testing Rails With RSpec and Capybara

Today we'll be testing the Music App you created. Use your code from that assignment.

## Setup

Follow the instructions for setting up [RSpec-Rails][rspec-rails], [Shoulda Matchers][shoulda-matchers-docs], and [Capybara][capybara]. (Note: no need to use Factory Girl or Faker for this assignment - we'll save that for tomorrow.)

You'll also need to prepare your app for testing by adding the following lines to the files noted at the top of the snippets.
NB: use Atom's ⌘-t shortcut to quickly navigate around your rails project

```ruby
  # Gemfile

  group :test do
    gem 'factory_girl_rails', :require => false
    gem 'faker'
    gem 'capybara'
    gem 'launchy'
    gem 'shoulda-matchers'
    gem 'rspec-rails'
  end
```

```ruby
  # database.yml

  test:
    adapter: postgresql
    database: music_db_test
    pool: 5
    timeout: 5000
```

```ruby
  # test.rb

  # Configure default mail server
  Rails.application.routes.default_url_options[:host] = 'domain.com'
```

Note: if you're having difficulty getting your config to work, don't hesitate to check out the `spec_helper.rb`, `Gemfile`, and specs from the solutions.


## Model Tests

Run `rails generate rspec:model User` to generate a spec file for the `User` model.

Let's write some simple tests for the `User` model. Your test files should live in `spec/models/user_spec.rb`. Use shoulda-matchers to test all of the user's validations using the following as a blueprint:

```ruby
  # validations
  it { should validate_presence_of(:email) }
```

You should validate:
* Presence of `email`
* Presence of `password_digest`
* Length of `password` > 6

Refer to [the docs][shoulda-matchers-docs] as needed.

Next, it's time for a review of plain old RSpec! Write methods to test `#is_password?`, `#reset_session_token`, and `::find_by_credentials`.

Make sure to run your specs (`bundle exec rspec spec/models`) and [review the solutions][users-solutions] for the users model before moving on.

## Controller Tests

Run `rails generate rspec:controller Users` to generate a spec file for the `UsersController`.

Use the following skeleton. Fill in the pending specs to test each action in your `UsersController`. The first spec filled in for you:

```ruby
RSpec.describe UsersController, :type => :controller do

  describe "GET #new" do
    it "renders the new template" do
      get :new, {}
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of the user's email and password"

      it "validates that the password is at least 6 characters long"
    end

    context "with valid params" do
      it "redirects user to bands index on success"
    end
  end
end

```

## Integration Tests

Next, it's time to practice writing an integration test.

Your integration tests should live in the `spec/features/` folder. Create a new file in this folder called `auth_spec.rb`.

Copy in the following skeleton and implement the pending specs to test your auth pattern. Refer to the [Capybara reading][capybara] as needed.

**Note:** Capybara is a very picky creature. When Capybara is instructed to do something like `fill_in 'username'`, Capybara will only execute the command correctly if the label is "username" exactly, case sensitive. Make sure that the text on your labels, forms, and headers are exactly as Capybara expects below.

```ruby
feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New user"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'Email', :with => "testing@email.com"
      fill_in 'password', :with => "biscuits"
      click_on "Create User"
    end

    scenario "redirects to bands index page after signup"
  end

  feature "with an invalid user" do
    before(:each) do
      visit new_user_url
      fill_in 'Email', :with => "testing@email.com"
      click_on "create user"
    end

    scenario "re-renders the signup page after failed signup"
  end

end
```

Congrats! You are on your way to becoming a master of Capybara! Make sure to review the solutions.

[rspec-rails]: ../../readings/rspec-and-rails-setup.md
[shoulda-matchers]: ../../readings/shoulda-matchers.md
[shoulda-matchers-docs]: https://github.com/thoughtbot/shoulda-matchers
[capybara]: ../../readings/capybara.md
[users-solutions]: ../../projects/music_app/solution/spec/models/user_spec.rb
