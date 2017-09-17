# ReduxTodos Day 1 - Frontend

## Overview

[Live Demo!][demo]

In this project, you will create an app that lets people create and manage a
todo list. Users of your app will be able to add items to their todo list,
delete items from it, and mark items as either "done" or "not done". Eventually,
every item in the list will be able to have its own sub-list of "steps" that can
be added, deleted, and marked or unmarked as "done".

Today's project uses exclusively React/Redux. Tomorrow, we will expand this project to use a Rails API backend so that
every change made on the frontend will persist!

## Phase 1: Frontend Structure

In this phase you will create a file system to structure your frontend,
configure your npm packages and webpack, and test that your frontend
configuration works.

* Model your project folder to look like the directory tree below:

  ```
  index.html
  bundle.js (no need to create this file, webpack will create it for us)
  frontend
    * actions
    * components
    * reducers
    * store
    * util
    todo_redux.jsx
  ```

* Run `npm init -y` and then `npm install --save webpack react react-dom redux react-redux babel-core babel-loader babel-preset-react babel-preset-es2015 lodash` to set up React and Redux
  * This command installs the npm packages that we will be using to create our React/Redux app.
* Set up your `webpack.config.js` file so that your bundle.js is saved in the root directory of your project. If you need to remind yourself how to set up the file look [here][webpack_setup].
* Start `webpack --watch`
**Test your setup** - Set up your entry file `todo_redux.jsx` to render
`<h1>Todos App</h1>` into your root page's `#content` container. Open `index.html` and confirm that it worked.

[webpack_setup]: ../../readings/webpack_configuration.md

---

## Phase 2: Todos Redux Structure

In this phase you will create a Redux loop, including a store with reducers, action creators and constants.

### State Shape

We want to build a state that allows us to easily add, remove, and update todos.
If we stored our list of todos in an array, then querying, updating and deleting any
todo would be O(n). Using a hash to store our todos yields O(1) for the same
operations given the id of any todo.

So the `todos` slice of our application might look something like this:

```javascript
{
  1: {
    id: 1,
    title: 'wash car',
    body: 'with soap',
    done: false
  },
  2: {
    id: 2,
    title: 'wash dog',
    body: 'with shampoo',
    done: true
  },
}
```

**NB**: `todo.id` is used as the primary identifier i.e. object key.

### Action Creators

Let's write a couple action creators. These are functions that will create the Redux
`actions` that will later tell your `todosReducer` how to update the state. The first
one will receive `todos` and populate the store, and the second one will receive a
single `todo` and either add or update a single todo in the store.

Remember that:
  * Redux actions are plain-old javascript objects that have a `type` property.
  * Action creators don't directly interact with reducers or the `store`,
  they simply return action objects.
  * These returned action objects are passed through our
  `rootReducer` only when `store.dispatch(action)` is called.

Create a file `actions/todo_actions.js` that will house our action creators and action type constants.

#### Action Type Constants

We use constants to represent action types. They are used whenever
action types are being set or read (i.e. in our action creators and in the
`switch` statements in our reducers and middleware).

Create and export `RECEIVE_TODOS` and `RECEIVE_TODO` action types like this

```javascript
export const RECEIVE_TODOS = 'RECEIVE_TODOS';
export const RECEIVE_TODO = 'RECEIVE_TODO';
```

#### `receiveTodos`

This action creator lets our reducer know to reset the list of `todos` and, as such, will
also need to pass along a new set of `todos`. Write your `receiveTodos`
action creator so that it accepts an array argument `todos`. It should return an action object with
a `type` property pointing to `RECEIVE_TODOS` and a `todos` property pointing to the `todos`
argument you're passing in. This represents all of our todos data.

#### `receiveTodo`

This action creator is formatted in the same way as `receiveTodos`, but accepts an argument/has a property of just
a single `todo`. Write this out now. We will describe its function later.

### Reducers

#### `todosReducer`

Redux reducers manage the shape of our application state.

* Create and export your `todosReducer` in a file `reducers/todos_reducer.js`.

A Redux reducer accepts two arguments:
* `state` - the previous application state.
* `action` - the action object being dispatched.

Remember that reducers should:

* Return the initial state if the state argument is undefined.
* Return the `state` if the reducer doesn't care about the action.
* Return a new state object if the reducer cares about the `action`.

**N.B.** The reducer must never mutate the previous state. Instead, it should return a brand new state object with the necessary changes.

Let's start by setting up our `todosReducer` to return its default
state - an empty object with no todos. **Do not move on to the other cases just yet**:

```js
const todosReducer = (state = {}, action) => {
  switch(action.type) {
    default:
      return state;
  }
};

export default todosReducer;
```

#### `rootReducer`

* Create a new file, `reducers/root_reducer.js`.
  * This file will be responsible for combining our multiple, domain-specific
  reducers. It will `export default` a single `rootReducer`.
* Import `combineReducers` from `redux`.
* Import your `todosReducer` function.
* Create a `rootReducer` using `combineReducers`.

So far, our default application state looks like this:

```js
{
  todos: {}
}
```

### Redux Store

A Redux store holds a reference to an application state. The store handles
updating state when actions are dispatched and tells the necessary components to
re-render. Let's create our Redux store.

* Create a new file, `store/store.js`
* Refer to the [store reading][store_reading] if needed
* Import `createStore` from the `redux` library
* Import `rootReducer`
* Create a function `configureStore` which calls `createStore` with the `rootReducer`
  * **NB:** While `configureStore` may seem meaningless now, it is a pattern we will be following throughout the course.
    This will come in handy when we begin working with `preloadedState` and middlewares, or if you want to use hot-module replacement or other snazzy add-ons.
* Export `configureStore`

**Test your code** - Import the store to your entry file. Create your store by calling
`configureStore`, set `window.store = store` and call `window.store.getState()` in
your console. Make sure that this function returns the initial application state
described above. Don't move on until it does!

**NB**: Keeping your `store` on the `window` while working on a Redux app is a
very handy and quick way to ensure that your state is changing the way you
expect it to given any user interaction, AJAX call, Redux action. However,
**you should only do this while developing**, be sure to remove it later.

Try setting a initial value for state in your `todosReducer`. Feel free to use this as a template.

```js
// reducers/todos_reducer.js
const initialState = {
  1: {
    id: 1,
    title: 'wash car',
    body: 'with soap',
    done: false
  },
  2: {
    id: 2,
    title: 'wash dog',
    body: 'with shampoo',
    done: true
  },
};

const todosReducer = (state = initialState, action) => {
  //...
}
```

It isn't typical to have so much data in the initial state,
but it will speed up our development to have some real todos to test our code on.

**Test your code** - Try calling `window.store.getState()` again from the
console. Does your store's initial state match the default state you defined?


#### Receiving and Reducing `todos`

Now that you have a functioning store, let's test out those actions we created earlier. Inside of the `todosReducer`, implement the following.

* Import action constants `RECEIVE_TODOS` and `RECEIVE_TODO`.
* Add a new `case` to the `switch` statement in your `todosReducer`
  * This case should execute if the `action.type` is `RECEIVE_TODOS`
  * The `todos` data in your store should be replaced by the data in `action.todos`
  * Do not merge the old `todos` state with the new `todos` coming in
* Add another `case` to the `switch` statement to handle `RECEIVE_TODO`
  * This case should return a new state object, either adding the `todo` in the `action` to
  the previous state, or replacing a `todo` in the previous state at the same object key.
  * You do not need an if/else statement for this functionality.

Remember, you must not mutate state! If you want to change a data structure you must copy it first.
The built in `Object.assign` method is perfect for this. Just make sure the first argument is a new blank object to avoid mutations.

Your reducer should look something like this.

```javascript
const todosReducer = (state = initialState, action) => {
  switch(action.type) {
    case RECEIVE_TODOS:
      const newState = {};
      // iterating through action.todos setting a key value pair for each one in the new state.
      // return the new state
    case RECEIVE_TODO:
      // Make a new object setting a single key value pair for action.todo
      // Return a new state object by merging your previous state and your new object
    default:
      return state;
  }
};
```
**Test your code!**

You should now be able to run the following in the console:

```javascript
const newTodos = [
  { id: 1, ...etc },
  { id: 2, ...etc },
  ...etc
]
store.getState(); // should return default state object
store.dispatch(receiveTodo({ id: 3, title: 'New Todo' }));
store.getState(); // should include the newly added todo
store.dispatch(receiveTodos(newTodos));
store.getState(); // should return only the new todos
```

Examine your state object - Is it the shape we had decided it should be back in
the reducers section? Specifically, are the `todos` being stored as values in an
object? If it is not, refactor the code in your reducer so that your `todos` are
being stored correctly. **Test again.**

**NB**: You've now implemented a full Redux cycle! Call over a TA for a code review.

## Phase 3: Todos Components

In this phase, you will create React components to display your todo list and its items

### `App`

This component will hold all of the top-level concerns/components of your app. A top-level
concern is a feature of the app that functions on its own and as such is not
nested under any other features. In this case, that will only be the `TodoList`,
but nonetheless it's a good design pattern to get used to. You should define `App`
in `frontend/components/app.jsx`.

Your `App` component can also be functional, because it doesn't need to use any
of React's lifecycle hooks. Because it doesn't rely on any of its props, the
component doesn't need to receive any arguments.

To test your component, make your `App` component return a `h1` tag with the
name of your app and temporarily render it in your entry file.

```js
ReactDOM.render(<App />, rootElement);
```

Make sure it works before continuing!

### `Root`

The `Root` component serves to wrap your `App` component with a `react-redux`
`Provider`. Remember that the `Provider` gives all of your components access to your
`store`, allowing them to read the application state and dispatch actions.

* Create a file `components/root.jsx`.
* Import React and the `react-redux`'s `Provider`.
* Import your `App` component from `./app`.
* Export `Root` as functional component that receives props as an argument and returns a block of `jsx` code.
  * It receives your `store` as a prop.
  * Consider de-structuring `props`.

Our `Root` looks like this:

```javascript
const Root = ({ store }) => (
  <Provider store={ store }>
    <App />
  </Provider>
);

export default Root;
```

* Update your entry file to render your `Root` component instead of `App` into `#content`!

### Selectors

Great! We're ready to start creating our components! **BUT WAIT!** We'll be
taking in some data from the store, but we want it in a specific format for
our components to use. That's where selectors come in! [Selectors][selector_reading]
are "getter" methods for the application state.
They receive the state as an argument and return a subset of the state
data formatted in a specific way. We will explore them in more detail but for now
all we need is a function to transform an object filled with todos, into an array
for easy consumption by our components.

* Create a file `reducers/selectors.js`.
* Export a function named `allTodos` that receives the entire state as an argument.
  * Use `Object.keys(state.todos)` to get the keys for the `state.todos`.
  * Map the array of todo ids to an array of todos.
  * Return your new array.

**Test your selector** - Put your selector on the `window` and pass it the
default state. Does it format the data into an array of `todos`? Once your selector is working great, let's put it to use on our `TodoList`!

### TodoList

This component will display the items in our todo list.

**NB**: Because we're using the react/redux design principle of separating
container and presentational components, this will actually be two components!

#### `TodoListContainer`

The goal of a container component is to allow the presentational component to be
as simple and lightweight as possible. To this end, we map the application state
and the Store's `dispatch` function to a set of props that get passed to the
presentational component.

Refer to the [components][components_reading] and [connect][connect_reading]
reading if you need a refresher on container components.

* Create a file `components/todo_list/todo_list_container.jsx`
* Import both the `connect` function and the (as of yet unwritten) `TodoList` presentational component
* Create a `mapStateToProps` function
  * Create a prop called `todos` whose value is the return value of your `allTodos` selector passed the `state`
* Create a `mapDispatchToProps` function
  * Create a prop called `receiveTodo` that accepts a `todo` and invokes a call to `dispatch` with the action returned from the `receiveTodo` action creator
* Pass your `mapStateToProps` and `mapDispatchToProps` functions to `connect`
* Call the result of this `connect` function with your `TodoList` presentational component as an argument
* Export the result of this function call

Your prop mapping functions should look like this:

```js
const mapStateToProps = state => ({
  todos: allTodos(state)
});

const mapDispatchToProps = dispatch => ({
  receiveTodo: (todo) => dispatch(receiveTodo(todo))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(TodoList);
```

#### `TodoList` and `TodoListItem`

Create your `TodoList` presentational component.

If we've done our job with our container component, all this presentational
component will have to do is render the titles of its `todos` prop as list items inside of a `<ul>`

**Test your code** - Add `TodoListContainer` to your `App` component. Reload your app and see your list of `todos`!

Now, let's refactor this `<ul>`/`<li>` structure so that each list item is a
`TodoListItem` component that receives the appropriate item as a prop. Each
`TodoListItem` will render the title of its item inside an `<li>`.  

* Create a file `components/todo_list/todo_list_item.jsx`
* Create a React Component called a `TodoListItem`
* Write a `render` function for that component that returns an `<li>` with `this.props.todo.title` inside it
* The `TodoList` component should render `TodoListItem`s and give them the necessary props.

**Test your code** - Refresh your page - everything should look the same!

---
## Phase 4: `TodoForm`

In this phase you will create a form that allows users to create new todo items.

* Create a new component (`components/todo_list/todo_form.jsx`).
  * This component will use controlled inputs to keep track of its form data; thus it will have a local state
    * If you don't remember how to set up controlled inputs in a React component, look at this reading about [props and state][props_and_state_reading]
  * Render this component in your `TodoList` component
* Update your `TodoList` to pass `receiveTodo` down to your `TodoForm`

Before you create your todos by calling `receiveTodo` on submission of the form, we
need to give our todos unique ids. Usually, our database would take care of this for us.
As an easy way to get unique sequential numbers, use the current unix timestamp.
Make a util file to export the following function (or something similar).

```javascript
function uniqueId() {
  return new Date().getTime();
}
```

**Test your code** - Try creating a new todo list item using your form. Does it
appear on your page? Call over a TA for a code review.

---
## Phase 5: Updating And Deleting Todos

In this phase, you will add new actions and buttons so that you can mark `todo`s as `done` or `undone` as well as delete them.
* Create new action creator methods (in `actions/todo_actions`)
  * `removeTodo`
* Add a new `case` to your reducer's `switch` statement that handles the deletion of a todo list item
  * `REMOVE_TODO` should cause that item to be removed from future versions of `state.todos`
* Update your components so that you can dispatch and view the effects of these actions
  * Add `removeTodo` to the `MapDispatchToProps` in your `TodoListContainer`
  * Pass those functions as props to your `TodoListItem` components
  * Render a delete button that will call `removeTodo` with the current todos id `onClick`.
  * Render 'done' button that will call `receiveTodo` with the current todo and it's status flipped.
    * The `Done` or `Undo` button should display the current state of the todo item
      * Hint: Write a helper method to update the todo item's `done` attribute when the button is clicked
      * Call `updateTodo` to change the status of the todo item

**Test your code** - You should now be able to create, toggle, and delete todo
items on your list.

---

## Phase 6: Steps Redux Structure

### Refactoring and Setup

In this phase you will update your app so that each todo list item can have its
own sub-list of `steps`. You will need to build out your redux
cycle, as well as add several new components for this to work.

Steps will have a `title`, a `todo_id`, and a boolean `done` value.

**You should be testing your code regularly as you finish features like we
did for Todos. It will save you a lot of time if you debug as you code.**

Let's start by getting your `TodoListItem`s ready for their own sub-lists by
refactoring their display into multiple parts. We will wrap the `TodoDetailView`
in a container component so that it can dispatch functions and receive
information from the `store`. Follow these steps:

* Create a container for your `TodoDetailView` component
  * Create a `MapDispatchToProps` function that passes `removeTodo` as a prop to `TodoDetailView`
  * Export `connect(null, mapDispatchToProps)(TodoDetailView);` (null because the first argument to connect must always be mapStateToProps)
* Create a file `components/todo_list/todo_detail_view.jsx` to hold the presentational component `TodoDetailView`
  * Refactor your `TodoListItem` so that it only renders the item's title and a button to change its status
  * Fill out your `TodoDetailView` so that it renders all of the todo item's other information
  * Conditionally render the `TodoDetailView` so that a user can show or hide a todo's details
    * Add a boolean value `detail` to the internal state of your `TodoListItem`
    * Initially, set that value to false
    * Allow users to change that value to true by clicking on the item's title
    * Render the `TodoDetailView` only if `detail` is true

**NB**: Eventually, your `TodoDetailView` will hold a `StepList` component that
will hold all of the `Steps` for a given `TodoListItem`. We will also update
the `TodoDetailView` container to request `Steps`.

#### Action Creators

In this section you will create essentially parallel action creators to those in your `todo_actions` file, but for `steps` instead.

* Create a file `actions/step_actions.js`
  * Write action creators `receiveSteps`, `receiveStep`, and `removeStep`
  * Create new `step` constants for each of the action creators
  * Export all of your action creators and constants

**Test your code.**

#### Reducers

* Create another reducer called the `stepsReducer` in `reducers/steps_reducer.js`
  * Set a default action to take in its `switch` statement
  * Add this reducer to your `rootReducer` via `combineReducers`
* Add another selector to your `reducers/selectors.js` file that will allow components to get the steps as an array.
  * Write a function `stepsByTodoId(state, todoId)`
  * You will need to loop through all the steps searching for the ones with the correct `todoId`.

**Test your code.**

#### Update the store

We'll store our steps the same way as todos, in an object keyed by id.
This structure is the easiest to maintain and helps us avoid things like
duplicated data and complex reducers. If we want to re-nest our associated objects,
we can do so with selectors.

Your application state will end up looking like this:

```js
{
  todos: {
    1: {
      id: 1,
      title: 'take a shower',
      body: 'and be clean',
      done: false
    }
  },
  steps: {
    1: { // this is the step with id = 1
      id: 1,
      title: 'walk to store',
      done: false,
      todo_id: 1
    },
    2: { // this is the step with id = 2
      id: 2,
      title: 'buy soap',
      done: false,
      todo_id: 1
    }
  }
}
```

## Phase 7: Steps Components

In this phase, you will create React components to display the steps for a given
todo list item, as well as a form that allows users to create new steps. These
components will be rendered inside your `TodoDetailView` component.

Follow these steps, **testing your code as you go** :

* Add `receiveSteps` to the `mapDispatchToProps` in your `TodoDetailViewContainer` (we'll use this later)
* Create a pair of files, `components/step_list/step_list.jsx` and `components/step_list/step_list_container.jsx`
  * Create `mapDispatchToProps` and `mapStateToProps` functions in the container file
    * `mapDispatchToProps` will pass `receiveStep` as a prop
    * `mapStateToProps` will pass `steps` and `todo_id` as props
  * The presentational component should render:
    * A `<ul>` of `StepListItemContainers`A3
    * A `StepForm` (to be created later)
* Create a pair of files `components/step_list/step_list_item_container.jsx` and `components/step_list/step_list_item.jsx`
  * Create a `MapDispatchToProps` function in the container file
    * `MapDispatchToProps` will pass `removeStep` and `receiveStep` functions as props
  * The presentational component should render:
    * The step's `title`
    * The step's `body`
    * Buttons to toggle and remove the step
* Create a file `components/step_list/step_form.jsx`
  * The `StepForm` component should render:
    * A form with a labeled input and a button that creates a new step
  * The `StepForm` component should control the input by
    * Storing its value in state
    * Updating its state when the input triggers `onChange`
  * The `StepForm` should `handleSubmit`
    * Create a local `step` object
    * Pass that object to `this.props.receiveStep`
    * Clear the form fields.

**Test your code: You should be able to create, toggle, and destroy steps.**

## Bonus

### Persist State with localStorage

One major flaw with our app is that all the todo data is lost between page refreshes.
We will store this data in a database with Rails tomorrow,
but you can accomplish a similar effect for the end user
by storing the data directly in their browser. Users can't share information this way
(it is all local to their computer) but updates will persist through page refreshes.

Before beginning, [read up on `localStorage`](https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage).

#### Saving state in localStorage

We want our store to save to `localStorage` after every dispatch, (that is, every time our state has changed).
There are a few ways to go about implementing this behavior, the simplest of which is subscribing to the store as soon as it's created.
* Inside `configureStore`, once the store is created, call `store.subscribe` and pass it a callback.
* Inside the callback, call `store.getState` and save the results in localStorage.

Before moving on, verify that if you change your state through actions, the value stored in localStorage reflects those changes.

#### Loading from localStorage

We now want to be able to populate our store with the value saved in localStorage. We'll also do this inside of configureStore.
First, check if you have a value saved in localStorage. If you do not, create your store without an initialState. If there is a value, pass that is as the 2nd argument to `createStore`.

That's it! Try making some todos or steps and then refreshing the page. Do the changes you made persist?  

### Make it Beautiful

* Style your site so that it looks presentable to investors!
  * Make a styles folder in your root directory, and include any CSS files you write in `index.html`
  * Potential inspiration: [trello](https://trello.com/), [todoist](https://todoist.com/), [google keep](https://keep.google.com/), [any.do](http://www.any.do/anydo/), [wunderlist](https://www.wunderlist.com/)
* Add additional features:
* Allow users to update todo title & body
  * Sort by priority
  * Add a time when a 'todo' is due
    * Sort by due date

[store_reading]: ../../readings/store.md
[components_reading]: ../../readings/containers.md
[connect_reading]: ../../readings/connect.md
[props_and_state_reading]: ../../readings/props_and_state.md
[selector_reading]: ../../readings/selectors.md
[demo]: https://aa-todos.herokuapp.com/
[local-storage]: https://localstorage.com/

