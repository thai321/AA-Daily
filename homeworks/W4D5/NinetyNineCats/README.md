# Helpers, Layouts, and Partials Homework

We will be working off of the solutions for *99 Cats II: Auth* for today's homework assignment. Download the [zipped solution][99-cats-2-solution-zip], extract, `bundle install` and `bundle exec rake db:setup` to set it up.

## Topic 1: View Helpers

Isn't it pesky to have to rewrite the code for the `form_authenticity_token` field over and over? Let's abstract it into a simple helper method that we can use across our views.

Open up your `helpers/application_helper.rb` file and write a new method called `auth_token`. As a refresher, your auth token code in your views should look something like this:

```html
<input
  type="hidden"
  name="authenticity_token"
  value='<%= form_authenticity_token %>'
/>
```

Let's put this code in our new `auth_token` method, but with a few changes. First of all, we'll need to wrap the input tag in a string and call `#html_safe` on it. Otherwise, our `auth_token` method will output the string literal for our input tag. Secondly, now that our input tag is little more than a string in Ruby-land, we shouldn't interpolate the actual `form_authenticity_token` using erb tags. Instead, just interpolate `form_authenticity_token` using the string interpolation syntax we know and love (`#{}`).

Sweet! Looking good? Now go through your app and replace all of the `form_authenticity_token` input fields with calls to your snazzy new method, `<%= auth_token %>`, to dry up your code and simplify your life.

## Topic 2: Layouts

We've been using layouts in Rails every day without even knowing it! Let's check out our `application.html.erb` file. In particular, notice the `<%= yield %>` tag in the middle of the layout. This will yield in the content for whatever page we're on, whether that's the cats index or new user form.

Now, let's say we want to add a footer on our `application.html.erb` layout. We want our footer to display a paragraph describing our site on every page of our site. In addition, we want it to display a line describing the particular page we are on. This is a perfect time to use Rails's `content_for` method.

First, create a footer section in your `application.html.erb` at the end of the `body` tag, and write in a paragraph describing your site. Verify that this shows up on every page as you navigate around in localhost.

Next, let's add a second yield tag to insert the custom footer content within the new footer section. It should look something like this:

```erb
<footer>
  This is our 99 Cats site. Please feel free to browse!

  <%= yield :footer %>
</footer>
```

Now, time to add some page specific content. Go through each of your views, and add a line specific to that page. It should look something like this:

```erb
<p>Other content for the cats index goes here</p>

<% content_for :footer do %>
  <p>This is the cats index page.</p>
<% end %>
```

Finished? Navigate around your site in localhost. Make sure that the main body of each page appears in the main `yield` section of the layout, and that your footer-specific content appears in the footer.

## Topic 3: Action Mailer

1. Create a user mailer to welcome new users to your account. The `bundle exec rails generate mailer UserMailer` command will create a new mailer class file with some default code in `app/mailers/user_mailer.rb`.

  ```ruby
  class UserMailer < ApplicationMailer
    default from: 'from@example.com'
  end
  ```

2. Implement a `#welcome_email` method that will e-mail a user from `everybody@appacademy.io`.

  Need a hint? Refer back to the [mailer readings][mailer-reading-1].

  ```ruby
  class UserMailer < ApplicationMailer
    default from: 'from@example.com'

    def welcome_email(user)
      # your code here
    end
  end
  ```

3. Next, write the content for the e-mail welcoming the user to the site. Create a `welcome_email.html.erb` file in `app/views/user_mailer/` and fill it in.

  In addition to the `.html.erb` file, make a text-only version in `welcome_email.txt.erb`. Remember - omitting a text version of your email could make many filters interpret your email as spam!

4. When a user signs up for your app, send them the welcome e-mail. Where should that code live within our existing `UsersController`? Implement the code.

  Remember - we need a few things. We must call our new `welcome_email` method, which returns a message, and call `deliver_now` on that message to actually send it:

  ```ruby
  msg = UserMailer.welcome_email(@user)
  msg.deliver_now
  ```

5. Test it out! Set up the `letter_opener` gem so that you can try out your code on `localhost:3000`. The sent message should pop up in the browser if all went according to plan. Congrats! You've ActionMailed!

  ```ruby
  # Gemfile
  gem 'letter_opener', group: :development

  # config/environments/development.rb
  config.action_mailer.delivery_method = :letter_opener
  ```
[99-cats-2-solution-zip]: ../../projects/ninety_nine_cats_ii/solution.zip?raw=true
[mailer-reading-1]: ../../readings/mailing-1.md
