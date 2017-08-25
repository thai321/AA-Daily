# 99 Cats II: Auth

**[Live Demo!][live-demo]**

Today we add a users and login to our 99Cats application.

[live-demo]: https://ninetyninecats.herokuapp.com/

## Learning Goals

* Be able to create a user authentication system
  * Know the user model's methods that are required for authentication
    * `reset_session_token`, `password=`, `is_password?`, `find_by_credentials`
  * Know what it means to create and destroy a session
  * Know how cookies and sessions interact in a `current_user` method
  * Know how to access the current user from within a view

**NB**: Download the [skeleton][skeleton] containing solutions from day one.

[skeleton]: ./skeleton.zip

## Phase IV: Users

### Add a `User` model

* Store the `User`'s `user_name` and `password_digest`.
  * As ever, toss on necessary constraints and validations.
* Also create a `session_token` column.
  * Require the session token to be present. This means you'll need
    a `after_initialize` callback to set the token if it's not
    already set.
  * Add a unique index on `session_token`; no two users should share
    a session token.
* Write yourself a `User#reset_session_token!` method. Go on, you're
  worth it! Use yourself a `SecureRandom` to generate a token.
* Write a `#password=(password)` setter method that writes the
  `password_digest` attribute with the hash of the given password.
* Write a `#is_password?(password)` method that verifies a password.
* Write a `::find_by_credentials(user_name, password)` method that
  returns the user with the given name if the password is correct.

### `UsersController`, `SessionsController`

To allow signup, write a `UsersController` with `new`/`create` actions.
Add appropriate routes.

Build a `SessionsController`:

* Add a singular `:session` resource in `routes.rb`
  * A visitor to your site implicitly has their own session
    (it's stored in their browser), so there's no need to create
    routes for different sessions. Only `new`, `create`, and
    `destroy` are needed.
* In `SessionsController#new`:
  * Render a form for the user to input their username and password.
* In `SessionsController#create`:
  * Verify the `user_name`/`password`.
  * Reset the `User`'s `session_token`.
  * Update the `session` hash with the new `session_token`.
  * Redirect the user to the cats index page.
* We'll worry about `SessionsController#destroy` in the next section.
* Don't forget to add the corresponding views!

### Using the session

* In the `ApplicationController`, write a method `current_user` that
  looks up the user with the current session token.
  * Since all your controllers inherit from `ApplicationController`,
    this lets you use the method in any controller.
  * Methods defined on `ApplicationController` still aren't
    available in your views. You'll want to use `current_user` there
    too, so you need to make it a [`helper_method`][docs-helper_method].
    Add this line to the top of `ApplicationController`:
    ```ruby
    helper_method :current_user
    ```
* Use `current_user` to implement `SessionsController#destroy`.
  * Call `#reset_session_token!` on `current_user` to invalidate the
    old token, but only if there is a `current_user`.
    Invalidating the old token guarantees that no one can login with
    it. This is good practice in case someone has stolen the token.
  * Blank out `:session_token` in the `session` hash.
* Edit the `application.html.erb` layout and create a header at the top:
  * Show the username if the user is signed in.
  * Show a login or logout button, depending on whether a user is
    signed in.
* Be sure to login a new user as soon as they sign up. Nothing is
  more frustrating than going through the whole signup process only
  to be redirected back to the login page. Bad form.
* At this point, you should probably factor out the login code from
  `SessionsController#create` into an `ApplicationController#login_user!`
  method so that you can use it in `UsersController` for this purpose.
* In the User and Session controllers, use a `before_action` callback
  to redirect the user to the cats index if the user tries to visit
  the login/signup pages when they're already signed in.

[docs-helper_method]: http://apidock.com/rails/ActionController/Helpers/ClassMethods/helper_method

### CSRF time!

* Re-enable CSRF protection. Add `protect_from_forgery with:
  :exception` back to the `ApplicationController`.
* Any form that does not upload the `form_authenticity_token` will
  cause Rails to throw an error, because it won't know if the POST
  request is coming "cross-site".
* Fix your forms, friend!

## Phase V: Using `current_user` with Cats and CatRentalRequests.

### Cats have an owner

* Add a `user_id` column to `cats`. As always, index the foreign key.
* Add `owner` and `cats` association.
* Validate the presence of `owner`.
* In the create action of the `CatsController`, you'll need to be sure
  `user_id` gets set to the current user's id.

**NB:** You **should not** use a form field for `user_id`, even a
hidden one.

Using a hidden field does not guarantee that the value will be sent
back unmodified. A user can always right click on the form, "inspect
element", and edit the value of a hidden field. Or if they're really
a `l33t h4x0r`, they'll just create a request manually and send you
any data they want.

In this case, if we embed a tag:

```html+erb
<input name="cat[user_id]" type="hidden" value="<%= current_user.id %>">
```

We can't be sure a malicious user won't inspect the element and modify
it to the ID of another user. That would allow a user to maliciously
create cats for other users.

Never trust any data sent from the client where security is involved.
You do not control the client, therefore you cannot trust it.

In this case, the form submitter must be logged in or they couldn't
view the form to begin with, so we can set `cat.owner` to the
`current_user` without relying on any form inputs.

* In the `CatsController` `edit`/`update` actions, make sure the
  editor owns the cat.
  * Use a `before_action` callback to accomplish this.
  * Instead of using `Cat.find`, try searching for the cat among
    only the `current_user`'s cats with the `User#cats` association.
    Remember, `has_many` associations are lazy-loading and behave
    like scopes when you tack query methods on the end. Doing this
    gives the added security benefit of not even loading the cat
    if it doesn't belong to the user.
  * Do a `redirect_to` in the filter if the user is not authorized.
  * Note that redirection from inside a `before_action` cancels
    further processing of the request. The action will never be
    called.

**NB:** It is insufficient to only protect the `edit` endpoint. You
  must also protect `update`. A malicious user could make a PUT request
  directly to `/cats/123` using [Postman][postman] or a similar tool and
  update the cat anyway. In fact, protecting `edit` doesn't really do
  much when it comes to security. We do it for good UX; a non-malicious
  user who accidentally tries to edit another person's cat gets feedback
  that they're not allowed to.

* Do likewise for `CatRentalRequestsController`; only the cat owner
  should be able to approve/deny.
* On the cat show page, don't show the approve/deny buttons unless the
  user owns the cat.

[postman]: https://www.getpostman.com/

### CatRentalRequests have a requester

* Add a `user_id` column to `CatRentalRequest` to record the ID of the
  **requester** (not to be confused with the *cat owner*).
  * Don't forget to add an index.
  * Set up the `belongs_to` and `has_many` associations between
    `CatRentalRequest` and `User`.
  * Validate that there is a requester.
* Be sure to assign the `current_user` as the requester in the
  `CatRentalRequestController`'s create action. Again, don't
  trust any form inputs.
* Display the requesting user's username next to each rental request
  on the cat show page.

## Bonus

### Optimizing

* When you display the requesting user for each rental request, does
  this generate an `N+1` query? Use `includes` to fix it.

### Multiple Sessions

Your cat rental request app is becoming very popular! Your users want
to be able to login to your app from multiple browsers and devices at
the same time.

* Once you think you know how to implement this, call your TA over
  and explain it.
* Change your app so you can login from multiple devices. (you can
  test this using Chrome incognito).
* Implement functionality so that logging out from one browser won't
  log them out from other devices.
* Allow users to see everywhere they're logged in and let them log out
  of each individually.
  * Give them information about each session so they know if they're
    logging out of their iPad or computer. Hint: `request.env`. Test
    that this works from different browsers (e.g. Chrome and Safari)
  * Pro status: Tell them where (physically) they logged in.  Hint:
    geocoder gem & `request.remote_ip`.
    * NOTE: If you are running your app on `localhost`,
      `request.remote_ip` will return your local IP (not your public IP).
      Unfortunately, this means you will need to host your app elsewhere
      (perhaps [Heroku][heroku]) in order to get good location results.

[heroku]: http://www.heroku.com/
