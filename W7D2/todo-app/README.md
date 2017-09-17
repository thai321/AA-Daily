# ReduxTodos Day 2 - All Together Now

## Overview

[Live Demo!][demo]

Today we will continue building from the frontend only todo app you built yesterday
and incorporate Rails so that our todos can be persisted on the backend and users can be authenticated.
We will also learn to use and implement thunk middleware to handle asynchronous actions. Let's get started!

## Phase 0

If you haven't already, finish part one of the project through phase 5 (up to, but not including, steps). You will not need to have steps implemented to work with most of today's project, but you will need a working todo form.

## Phase 1: Rails API

In this phase you will create a Rails API that stores todos in a database
and serves JSON in response to HTTP requests.

**NB**: We first saw use of a Rails API in AJAX Twitter! Today, we will create
a Rails API that will have controllers and models but will not have HTML
views. Instead of being a full-stack app, its purpose will be to serve
information between our Postgres database and React/Redux front-end. It will
respond to HTTP requests using `Controller#Actions`, the same way as before.
Its responses, however, will be JSON instead of HTML. On the client side, we will
make requests for these JSON views, and will parse and display them via our React components.
User interactions with React components will dispatch actions to our Redux store
that either fire AJAX requests or render the newest application state.

Let's get started!

* Create a new rails project using `--database=postgresql` and `--skip-turbolinks`
* Update your Gemfile with `pry-rails`, `binding_of_caller`, `better_errors` and `annotate`.

### Todos
* Create a `Todo` migration and model with a `title` string (required), a `body` string (required), and a `done` boolean (required).
  * Add the necessary validations to the database and model.
    * NB: Validating boolean fields at the model level can create interesting bugs. `presence: true` will
    fail because Rails checks for presence by calling `blank?` on the validated attribute.
    Since `false` is considered `blank` it will fail the validation. Instead, use
    `validates :boolean_field_name, inclusion: { in: [true, false] }`
    at the model level to validate boolean fields.
* Make sure Postgres is running on your machine
  * Run `rails db:create`.
  * Run `rails db:migrate`.

**Test your setup** - Try creating a couple of todos in your database using the
Rails console (`rails c`).

* Create an `Api::TodosController` to handle our API requests for todos.
  * It should create `app/controller/api/todos_controller.rb`.
* Define `show`, `index`, `create`, `update`, and `destroy` actions in your controller.
* Make your controller actions serve JSON-formatted responses.
* Define a private helper method for `todo_params`.

For example, your `show` and `create` actions should look like this:

```rb
# app/controller/api/todos_controller.rb
def show
  render json: Todo.find(params[:id])
end

def create
  @todo = Todo.new(todo_params)
  if @todo.save
    render json: @todo
  else
    render json: @todo.errors.full_messages, status: 422
  end
end
```

### Routes

* Create routes for `:index`, `:show`, `:create`, `:destroy`, and `:update`.
* Nest your routes under [namespace][namespace-docs] `api`.
* In `config/routes.rb`, set `defaults: {format: :json}` for your `api` namespace.

**Test your routes** - You should get the following when you run `rails routes`.

```
api_todos GET    /api/todos(.:format)     api/todos#index {format: :json}
          POST   /api/todos(.:format)     api/todos#create {format: :json}
 api_todo GET    /api/todos/:id(.:format) api/todos#show {format: :json}
          PATCH  /api/todos/:id(.:format) api/todos#update {format: :json}
          PUT    /api/todos/:id(.:format) api/todos#update {format: :json}
          DELETE /api/todos/:id(.:format) api/todos#destroy {format: :json}
```

### StaticPages

* Create a `StaticPagesController` that will serve a `root` view with `<div id="content"></div>`.
* Update `routes.rb` to `root to: 'static_pages#root'`.

Since Rails 5 doesn't include jQuery for us, we're going to need to do one more thing to get jQuery's `ajax` to work.
To add jQuery to your project:

1. Add `gem jquery-rails` to your `Gemfile`.
2. Run `bundle install`.
3. Add `//= require jquery` and `//= require jquery_ujs` to your `application.js`
4. If your Rails server was previously running, restart it.

You're almost ready to go!

* Seed your database with a few todos for testing.
* Start your server (`rails s`) so that it can respond to HTTP requests.
* Visit [http://localhost:3000/](http://localhost:3000/). It should render your root page.
  * Inspect the page and double check that `<div id="content"></div>` is present.

**Test your API** - Try out your API endpoints using `$.ajax`. You should be able
to send `POST`, `GET`, `PATCH`, and `DELETE` requests and receive the appropriate
responses in the console.

For example, try:

```js
$.ajax({
  method: 'GET',
  url: '/api/todos'
}).then(
  todos => console.log(todos),
  error => console.log(error)
);
```

[namespace-docs]: http://guides.rubyonrails.org/routing.html#controller-namespaces-and-routing

## Phase 2: Putting it all together

Your entire todos project from yesterday will function as the frontend folder for your rails app with some slight modifications.
You will also need your `package.json` and `webpack.config.js` which should be put in the root folder, but you do not need `index.html`.

Modify the output path in your webpack config to create bundle in `app/assets/javascripts` rather than the root directory. Take a look at `application.js`: because it includes the line `//= require_tree .` and the bundled file is in `app/assets/javascripts`, the bundled file will be required for you.

```json
"scripts": {
  "postinstall": "webpack",
  "webpack": "webpack --watch"
}
```

The `postinstall` script will run whenever you run `npm install`. This makes it
easier to setup your project on another machine, since you won't have to remember
to `webpack`. During development, you can run `npm run webpack` to keep your bundle
up to date.

**Test your setup** - You should be able to visit `localhost:3000` and confirm
that you have your entire work from yesterday working on `localhost:3000` before continuing.

Let's expand our Redux loop to include the entire internet!
That is, make requests to our Rails app and bring back todos from the database.
For this we will use an `APIUtil` and thunk action creators.

### API Utils

Your API utilities are what actually make the `$.ajax` requests that will hit
your backend and fetch your data. These utility functions should return a promise
so that the caller of the function can handle success and failure however they see fit.

Let's write our Todo API Util.

* Create a file `util/todo_api_util.js`.
* Write a function that takes no arguments, makes a request to `api/todos` with a method of `GET`, and returns a promise.

**Test your code** - Try running your function in the console and make sure
you can resolve the promise by passing a function to `then`.

### Thunk Middleware

Before we can start writing thunk action creators, we need a middleware to handle them.
Make a new file `frontend/middleware/thunk.js`. From this, export a single middleware function.
This function should check the type of each incoming action and see if it is of type `function`.
If so, return `action(dispatch, getState)`. If not, return `next(action)`.
Refer to the [middleware][middleware_reading] and [thunk][thunks_reading] readings
if you need more guidance.

Now modify your store to use your shiny new middleware. Inside `store.js`,
import `applyMiddleware` from `redux`, and the thunk middleware. As the last
argument to `createStore`, pass `applyMiddleware(thunk)`.

You can test that your thunk middleware is working by dispatching a function.
If the function is called, it's working!

```js
store.dispatch((dispatch) => {
  console.log('If this prints out, the thunk middleware is working!')
});
```

### Thunk Action Creators

#### Fetching Todos

Let's write an action creator to fetch todos from the server. Inside
`frontend/actions/todo_actions`, import your `APIUtil`, and export a function `fetchTodos`
which returns another function. The returned function should take dispatch as an argument,
and when invoked, call the `APIUtil` to fetch all todos. Resolve the promise by dispatching
your synchronous `receiveTodos()` action.

**NB: Return the resolved promise from the action creator for future flexibility; this allows you to continue chaining calls to `then` in the event that you would like to dispatch further actions from the component.**

Test it out! With your store and thunk action creator attached to the window you
should be able to populate your Redux store with todos from the database like so.

```js
store.dispatch(fetchTodos());
```

Once it's working, inside `todo_list_container.js`, include `fetchTodos` in `mapDispatchToProps`.
Inside `todo_list.jsx`, inside `componentDidMount` call `this.props.fetchTodos`. Test that
when you load the page the todo list is populated from the database.

#### Creating Todos

Now that we can fetch todos from the database, let's add the ability to save todos to the database.
First add a new function to your `APIUtil` which takes a todo and posts it to the server.
Inside `frontend/actions/todo_actions`, add a new thunk action creator `createTodo`, which takes a todo as an argument.
The returned function, when invoked, should call the `APIUtil` to create a todo and resolve the promise by dispatching
your synchronous `receiveTodo(todo)` action.

* Inside the `todo_list_container.js`, instead of passing in `receiveTodo` in `mapDispatchToProps`,
pass in `createTodo` and pass it through to `TodoForm`.
* Inside the `TodoForm` component, instead of `receiveTodo`, call `createTodo`.

Since we only want to clear the form if the post to the server is successful, clear the form after the promise resolves.
Since our thunk middleware returns the promise back to the caller, we can take on another `.then` to clear the form like so.

```js
// inside of handleSubmit
this.props.createTodo({todo}).then(
  () => this.setState({title: '', body: ''})
);
```

### Error Handling

We now have to deal with the unfortunate possibility that our request may fail.
When we attempt to create a todo with invalid params, the server will render a JSON array of errors.
We need a place in our Redux store to house these errors. Time for a new reducer!
Create `frontend/reducers/error_reducer`. Its initial state should be an empty array. Now let's write
some actions to modify this portion of state.

* Create `frontend/actions/error_actions`. You only need two sync actions here, `receiveErrors(errors)` and `clearErrors`.
* Create the necessary constants for each action, `RECEIVE_ERRORS` and `CLEAR_ERRORS`.
* Back in your reducer, handle these actions by either returning `action.errors`, or an empty array.

Now that we have somewhere to store errors, when todo creation fails, dispatch those errors.
You will need to update your `createTodo` action like this.

```js
const createTodo = todo => dispatch => (
  APIUtil.createTodo(todo)
    .then(
      todo => dispatch(receiveTodo(todo)),
      err => dispatch(receiveErrors(err.responseJSON))
    )
);
```

Verify that your error state is populated if you try to create a todo with invalid params.
Then, inside your todo form component, display the errors. You will need to pass the errors through
`mapStateToProps` of the top level component. Make sure to clear the errors when the todo is successfully created!

#### Updating Todos

This will be very similar to creating todos, (the resulting action will still be `receiveTodo`)
but we need a different action because we will hit a different route on the back end.
Add `APIUtil.updateTodo(todo)` and a new thunk action creator `updateTodo(todo)`
which dispatches `receiveTodo` upon success and `receiveError` on failure.
Update `toggleTodo` in `TodoListItem` to use your new action instead of calling `receiveTodo` directly.

#### Deleting Todos

You know the drill! Make your `APIUtil` function, and thunk action creator `deleteTodo` (it should dispatch
`removeTodo` on success). Update your components to use the new action.

## Phase 3: Steps

Once your todos have all their original functionality back and persisting to the database,
go through the same process with steps! You will have to write:

* The migration
* The model
* The controller
* The API Util
* The async actions

## Phase 4: Tags

Let's add tags to our todos.

* Create a Tag model with a `name` attribute.
* Create a taggings model. Taggings is a join table between todos and tags. Todos will `have_many` tags through taggings.
* We want our users to be able to define their own tags rather than selecting from a predetermined list, so rather than
an array of tag ids, we will expect tags to be sent to the back end as an array of tag names.
Let's write a model method to take care of settings the tags for a specific todo.
It should create the tag names sent up that do not already exist and find the ones that do.
It should remove old taggings and create new ones where appropriate. Active record allows you to do this by calling `collection=` and passing it a new collection. Our method looks like this.

```ruby
def tag_names=(tag_names)
  self.tags = tag_names.map do |tag_name|
    Tag.find_or_create_by(name: tag_name)
  end
end
```

* Inside your todos controller, add `tag_names` to the `todo_params`.
Remember the alternate syntax to allow the `tag_names` param to be an array.
When we create/update a todo, Rails will automatically call `tag_names=` for us.
This is similar to writing a custom `password=` method for auth.
* We need our todos to be rendered with their associated tags. You can tell Rails to
render associated items with the syntax `render json: @todos, include: :tags`. This approach can get messy
when including multiple associations. We will use Jbuilder in future projects to solve this problem.
* In your todo form, add a `tag_names` array to your component state and display `this.state.tag_names` in a `ul` inside the form.
You will also need an input to add new tags and a button to submit the new tag. However, we must be careful that this button
does not accidentally submit the form. To avoid this, make sure to use `<button type="button">`. Explicitly setting a type of
`button` overrides the default type of `submit`. On click of this button, add the input value to the current list of tags and clear the input.

## Phase 5: Authentication

Right now all users of our todo app share the same todos. Let's authenticate users
and only show them their own todos. You will not need Redux (or JavaScript at all)
for authentication today. We are going to authenticate our app the same way
we have up to this point. Frontend authentication is a topic that will be explored later this week.

* Create a user model with a `username` and all other columns needed for authentication.
* Create a users and session controller with `new` and `create` actions for both and `destroy` for session.
* Make Rails views for `users/new` and `sessions/new` (they can probably share a form partial).
* On successful account creation or log in, redirect users to `static_pages#root`.
* Use `before_action` callbacks to ensure logged in users get redirected from sign in routes to `static_pages#root`
and logged out users are redirected from `root` to `sessions/new`.
* Render a log out button inside of `static_pages#root` outside of your react content.
* Once you can sign up and sign in and out, associate todos with a user! Make a new migration to
add a `user_id` column to the `todos` table.
* In the todos controller, associate created todos with the `current_user` like so.
  ```ruby
  def create
    @todo = current_user.todos.new(todo_params)
    # ... etc
  ```
  * Do the same for update and destroy actions, searching only the current users todos.
  ```ruby
    @todo = current_user.todos.find(params[:id])
  ```
  * Lastly, modify the `index` action to only render the current user's todos.

  You now have a fully authenticated todo app! Celebrate!

## Bonus

* Disable your update and delete buttons while the dispatch is pending. Add a spinner!
Consider adding a `fetching` boolean to state and new sync actions like
`requestTodos` to tell the reducer to set `fetching` to true.
* Expand tags
  * Allow updating of tags from todo detail view
  * Filter todos by tag (filter on the frontend, or send tags in a query string on `fetchTodos`).
  * Tag suggestions (tag search on the back end) when inputing a new tag.
  * Steps can have tags (make taggings polymorphic, consider using a concern)
* Steps can have sub-steps (polymorphic associations)
* Allow markdown or text styling in todos ([quill.js](https://quilljs.com/))
* Allow users to update todo title & body
* Sorting by priority
* Adding a time when something is due
  * Sort by due date
  * Item pops up when it is due

[store_reading]: ../../readings/store.md
[thunks_reading]: ../../readings/thunks.md
[middleware_reading]: ../../readings/middleware.md
[components_reading]: ../../readings/containers.md
[connect_reading]: ../../readings/connect.md
[props_and_state_reading]: ../../readings/props_and_state.md
[selector_reading]: ../../readings/selectors.md
[demo]: https://aa-todos.herokuapp.com/

