# Music App

**[Live Demo!][live-demo]**

We're going to build an inventory system for record labels. This app
will let them track their `Band`s, `Album`s and `Track`s. Additionally
we'll offer user accounts so users can comment on our inventory.

[live-demo]: https://aamusicapp.herokuapp.com

## Learning Goals

+ Be able to build User Auth without looking at old code or demos
+ Know how to nest routes
+ Be able to link between different views using `a` tags and rails URL helpers
+ Be able to trigger controller actions from views using forms and links
+ Know how to check that a current user exists before displaying content

**Throughout this project, do not use `form_for`**.

## Warm Up: Authentication

Today, you will create a new rails application yourself, no
skeleton is provided! We recommend using `postgresql` for your
database.

Create a `User` model and bake in the prerequisites of
authentication. Let's use email addresses in lieu of usernames; in
the bonus phase, we'll use their emails to send confirmation
emails and other spam.

See if you can build auth without looking back at any old
code or demos. Here's a rough guide if you get stuck:

In the `users` table, you'll want to store an `email`,
`password_digest` and `session_token`. Make sure to add database
constraints (require all fields), and indices to ensure uniqueness
of `email`s and speed up the lookup by `session_token`.

* Write methods to deal with the session token:
  `User::generate_session_token`, `User#reset_session_token!` and
  `User#ensure_session_token`.
* Write a `User#password=(password)` method which actually sets the
  `password_digest` attribute using [BCrypt][bcrypt-documentation],
  and a `User#is_password?(password)` method to check the users'
  password when they log in.
  * Be careful setting instance variables in ActiveRecord, you can't
    just set `@password_digest`. In `#password=` use
    `self.password_digest=`. (`self.___=` calls an `attr_accessor`
    defined for us by ActiveRecord, which is the state that is saved by
    `self.save`. While `@___` makes a new instance variable,
    unrelated to `self.save`)
* Remember that in the `User` model, you'll want to use an
  `after_initialize` [callback][rails-guides-callbacks] to set the
  `session_token` before validation if it's not present.
* Write a `User::find_by_credentials(email, password)` method.

Next write a `UsersController` and `SessionsController`

* Write methods on the `UsersController` to allow new users to sign up.
  * Users should be logged in immediately after they sign up.
* Create a `SessionsController` but no `Session` model.
  * Write controller methods and the accompanying routes so that users
    can log in and log out. Should session be a singular resource?
  * `SessionsController#create` should re-set the appropriate user's
    `session_token` and `session[:session_token]`.
  * For now just redirect them to a `User#show` page which simply
    displays that user's email.

Finally, take some time to refactor out shared code & add some
convenience methods to `ApplicationController`. Make sure to include
the appropriate methods in your views as helper methods
(e.g. `helper_method :current_user`). You'll probably want:

* `#current_user` to return the current user.
* `#logged_in?` to return a boolean indicating whether someone is
  signed in.
* `#log_in_user!(user)` reset the `user`s session token and cookie


### Routes Summary

Your app should have routes for:

```
    session POST   /session(.:format)                     sessions#create
new_session GET    /session/new(.:format)                 sessions#new
            DELETE /session(.:format)                     sessions#destroy
      users POST   /users(.:format)                       users#create
   new_user GET    /users/new(.:format)                   users#new
       user GET    /users/:id(.:format)                   users#show
```

Create login/signup views and edit `application.html.erb` layout so that a logged in user is displayed a "sign-out" button and a logged-out user is displayed links to sign-up or sign-in pages.

### Styling

Spend a few minutes adding some styling to your session forms.
* Add a `Music App` header and with a snazzy font to `application.html.erb`
* Use `flex` to display our logged-in or logged-out info in the right-hand side of our `Music App` header
* Default link styling is pretty ugly, while keeping our `<a>` tags let's make our links look more like buttons by using `background-color` and `border-radius`
* Improve upon our session forms by changing the spacing and alignment of their elements

[rails-guides-callbacks]:http://guides.rubyonrails.org/v3.2.13/active_record_validations_callbacks.html#available-callbacks
[bcrypt-documentation]:https://github.com/codahale/bcrypt-ruby

## Phase I: Band/Album/Track

We'll put aside the `user` features for a moment and build out our
inventory system.

We want to build out a feature/resource at a time.
Let's follow this order per resource:
* Migrations
* Model definition (validations, associations, helper methods)
* Routes
* Controller + controller actions
* Views (should coincide with the actions that render them)

Here's what we need for each resource:

### Bands

* Create a `bands` table with a `name` (required) column (and don't forget timestamps)
* Create a `Band` model with a validation to ensure `name` is not null
* Create the following RESTful routes:
```
bands     GET    /bands(.:format)                       bands#index
          POST   /bands(.:format)                       bands#create
new_band  GET    /bands/new(.:format)                   bands#new
edit_band GET    /bands/:id/edit(.:format)              bands#edit
band      GET    /bands/:id(.:format)                   bands#show
          PATCH  /bands/:id(.:format)                   bands#update
          PUT    /bands/:id(.:format)                   bands#update
          DELETE /bands/:id(.:format)                   bands#destroy
```
* Create `BandsController` and actions/views to handle each of the routes
  * Create each view after finishing the controller action that would render it
  * Test as you go! Remember, we can use [Postman][postman-reading] to test `POST`, `PATCH` and `DELETE` actions prior to building our form views

[postman-reading]: ../../readings/postman.md

### Albums

Follow the same pattern for a new resource, `Albums`.

An `Album` should:
* Not be called `Record`, as ActiveRecord uses `record_id`
  internally.
* Belong to a `band` (don't forget to add the association to `Band` also)
* Have a `title`, `year`
* Designate whether it is a `live` or `studio` album
  * HINT: use a boolean paired with a reasonable default value
* Have the following routes:
```
new_band_album GET    /bands/:band_id/albums/new(.:format)   albums#new
        albums POST   /albums(.:format)                      albums#create
    edit_album GET    /albums/:id/edit(.:format)             albums#edit
         album GET    /albums/:id(.:format)                  albums#show
               PATCH  /albums/:id(.:format)                  albums#update
               PUT    /albums/:id(.:format)                  albums#update
               DELETE /albums/:id(.:format)                  albums#destroy
```
* For the views:
  * Have a drop-down to select which `Band` recorded the `Album`. Use
    `selected` to default-select the appropriate `Band` in the
    drop-down.
  * Use radio buttons to select whether the album is a live or studio
    album. Don't use a column named `type`, since Rails uses this for
    a special purpose and everything will break. Use `checked` to
    default select the appropriate value.
  * Make sure to provide links back to the album's band and make edit/delete buttons visible from the album's `show` page
  * Update the `Band` `show` page to list/link to all of the band's albums and create a new one

### Tracks

Yet again, follow the same pattern for a new resource, `Tracks`.

A `Track` should:
* Belong to an `album` (make sure to also add associations to `Band` and `Album`)
* Have a `title`, `ord` (track number) and optional `lyrics`
* Designate whether it is a `regular` or `bonus` track
* Have the following routes:
```
new_album_track GET    /albums/:album_id/tracks/new(.:format) tracks#new
         tracks POST   /tracks(.:format)                      tracks#create
     edit_track GET    /tracks/:id/edit(.:format)             tracks#edit
          track GET    /tracks/:id(.:format)                  tracks#show
                PATCH  /tracks/:id(.:format)                  tracks#update
                PUT    /tracks/:id(.:format)                  tracks#update
                DELETE /tracks/:id(.:format)                  tracks#destroy
```
* For the views:
  * You need a drop down to select the `Album`. Again, default select
    the appropriate `Album` in the drop down
  * Use radio buttons to mark a track as a "bonus" or "regular" track
    Again, default select the appropriate value
  * Use a `textarea` to allow the user to enter lyrics
  * Again, provide links the the track's album make edit/delete buttons visible from the track's `show` page
  * Update the `Album` `show` page to list/link to all of the album's tracks and create a new one

Add `dependent: :destroy` to applicable associations. Remember that
this option causes associated objects to be destroyed on `destroy`.

### Requiring Login

Make sure a user cannot view any of the `Band`, `Album`, `Track` data
without first logging in. If they are not logged in, bounce them to the
sign-in url with a `before_action`.

### Style it

Spend no more than 20 minutes adding some CSS to your views. Some ideas:
* Improve spacing/alignment of form elements
* Improve upon default list styling with a fancy flexbox grid
* Add page headers

## Phase II: Notes

Let's allow users to write notes about tracks. Let's "embed" the note
form on the track show page.

* Add a `Note` model. Users can take a `Note` on any `Track`.
  * `Note`s will belong to a `User` and a `Track`.
  * Use a `TEXT` column to store arbitrarily long notes.
  * Write appropriate presence validations.
* On the `Track` show page, display the track's `Note`s.
  * Write a `notes/_note.html.erb` partial.
  * Render the content, plus the author's email.
* Put a `Note` form on the `Track` show page.
  * Use a `notes/_form.html.erb` partial.
  * Use a `textarea` in the form. Do not store the `user_id` in a
    hidden field. **Why?**
  * On submit of a new `Note`, redirect back to the `Track`.
  * For this form, you can `redirect_to` the track even on
    validation failure. This "blanks out" the note content in the
    form. That would be bad, but the only real validation is that the
    content not be blank...
* Add destroy buttons for notes to the `notes/_note` partial.
  * Only show the button if the `current_user` authored the note.
  * In the controller, ensure that a user is not allowed to destroy
    a note unless they authored it.
  * Issue a 403 FORBIDDEN status if the user tries to destroy a note
    but they are not allowed to. Use `render text:` to give a
    bare-bones error message here. Don't worry about making this nice
    because someone would have to reverse-engineer your API in order
    to see it.

## Phase III: Helpers

In a fit of poor judgment, you have decided to display your lyrics
like this, with a music note before every line:

```
♫ And I was like baby, baby, baby, oooh
♫ Like baby, baby, baby, nooo
♫ Like baby, baby, baby, oooh
♫ I thought you'd always be mine (mine)
```

Write and use a helper `ugly_lyrics(lyrics)` that will:

* Break up the lyrics on newlines.
* Insert a ♫ at the start of each line (the html entity that will
  render as a music note is `&#9835;`).
* Properly escape the user input (avoid HTML injection attacks).
* Wrap the lyrics in a [`pre` tag][pre-tag] so that the newlines are
  respected (in a`<pre>` or _preformatted text tag_, whitespace is
  preserved).
* Mark the produced HTML as safe for insertion (otherwise your `<pre>`
  tag will get escaped when you insert it into the template).
* In Rails >= 4.2, you will need to `include ERB::Util` in your helper
  module.

## Phase IV: Validating Form Input

Now that you've got a site and users, they are bound to start making
mistakes!

On each form view, let's include the logic to display any errors that
our validations return.

* In your view, check if `@___.errors.full_messages` exists.
* If so, display each of them in its own stylish div!

## Bonus

Great work! Here are some bonus features to add to our inventory application.

### Bonus I: Additional Authentication Features

Spam-bots keep signing up for our inventory management
application. Let's defeat them by sending out an activation
email. We'll ask users to click a link to activate their account when
they sign up.

* On signup, send the user an email (via
  [ActionMailer][actionmailer-curriculum]).
* The email should contain a link to activate the new account.
* We'll need an `activated` boolean field on the user table to track
  the status of user accounts.
* Accounts should start out deactivated.
* We should add a check to see if a user is active before logging them
  in.
* To activate the accounts, we'll add an `activation_token` column.
* In the email, add a URL to `/users/activate?activation_token=...`.
* Add a custom route for a new action like `UsersController#activate`.
* You can use the [`collection`][adding-routes-rails-guides] method to
  do add additional routes to the users resources.
* This custom controller action, `UsersController#activate`, should
  verify that the user clicked the link in their email. If the token
  in the query string matches with the token in the database, it
  should activate the account and flip the boolean.  **Hint**: You can
  use [ActiveRecord's toggle method][ar-toggle] to elegantly flip the
  value of a boolean attribute.

[actionmailer-curriculum]:  ../../readings/mailing-1.md
[adding-routes-rails-guides]: http://guides.rubyonrails.org/v3.2.13/routing.html#adding-more-restful-actions
[ar-toggle]: http://api.rubyonrails.org/classes/ActiveRecord/Persistence.html#method-i-toggle

#### Testing Your ActionMailer

* Run `gem install mailcatcher`
* Run `mailcatcher`
* Open `http://127.0.0.1:1080/` in the browser
* Put the following code in your `environments/development.rb`:

```ruby
config.action_mailer.default_url_options = { host: 'localhost:3000' }
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = { address: '127.0.0.1', port: 1025 }
config.action_mailer.raise_delivery_errors = false
```

* Restart your rails server and send away!

### Bonus II: Admin Accounts

Let's add admin accounts for people from our record label. This way
our PR department can remove notes that don't reflect well on our
properties.

* Add an `admin` boolean to the user table.
  * Only admin users should be allowed to create/update/destroy
    inventory objects or notes.
    * Hide the links from regular users, and make sure to check if
      someone is an admin using a before filter on admin-only
      controller actions.
  * Users should be able to destroy their own notes.
    * Start tracking the author of notes to enable this, _i.e._
      `notes` belong to a `user`.
* Add a `users` index only visible to admin users.
  * Put a button next to each user which, when clicked, makes that
    user an admin.

### Bonus III: More Bonuses!

* Implement `tags`. Use [polymorphic associations][poly-assoc] to associate `tags` with
`bands`, `albums`, and `tracks`.
* Implement searching.
  * Users should be able to pick which model they want to search from.
  * Users should be able to just search in all three models at once.
  * Users should be able to search by `tags`.
* Read up on the [Faker][faker] gem and use it to create seed data for all
your models.
* Style your app!
  * Change the colors and font sizes for different elements.
  * Put your content in tables and play around with the positioning.
  * See if you can make your sign up and log in forms look nicer. Try
  centering them or adding a border.

[faker]: https://github.com/stympy/faker
[poly-assoc]: http://guides.rubyonrails.org/association_basics.html#polymorphic-associations
[pre-tag]:https://developer.mozilla.org/en-US/docs/Web/HTML/Element/pre
