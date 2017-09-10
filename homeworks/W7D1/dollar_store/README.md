# Dollar Store

Today, we're going to finish building out the architecture for a React
currency-conversion widget to use a Redux store. For this assignment, we won't
be using `Provider` or `connect()`. We will be using the store's three built-in
methods: `subscribe`, `dispatch`, and `getState`.

Take a look at the [live demo][live-demo] to see the app in action.  Try
clicking on a currency to see its conversion rates.

[live-demo]: https://appacademy.github.io/curriculum/currency_demo/

## Phase 0: Setup

To get started, download the [project skeleton][currency-skeleton].  Make sure to
run `npm install` to get all the required node modules. Run `npm start` (a handy npm script we've set up) to start `webpack --watch`. Note, there will
 be webpack errors but we'll work on fixing those right now.

[currency-skeleton]: ./skeleton.zip?raw=true

Poke around the components in the `frontend/components` folder and get
acquainted with them, especially the `Widget` component. Notice where we call
the store's built-in methods throughout:

- `subscribe` in the constructor
- `dispatch` in the AJAX's success callback
- `getState` in the render function

Now we need to make the actual Redux store so our `Widget` can successfully call all of those!

## Phase 1: Currency Redux Structure

Following the Redux pattern, a store should keep track of our application's
state. This means that when we make our AJAX request to fetch the currency
rates, it should update the store with its results. This is exactly what the
`success` callback in our `Widget`'s `$.ajax`' call is trying to do. But right
now, we don't have a store to dispatch to!

To make a fully-functional store, we need a reducer function, actions, and the
store itself.

### Creating a `store`

Let's start by defining our app's Redux `store`.

+ Open `frontend/store.js`.
+ We will need to import `createStore` from `redux`.
* Also import our `reducer` function from `frontend/reducer.js`. This is a dummy function which returns the default state, we'll replace it soon.
+ Then, all we have to do is call `createStore`, passing in the reducer function.
+ Don't forget to export it!

The entry file requires our `store` and passes it as a prop to the `Widget`
component. If you refresh the `index.html` page, you'll see a new webpack error:
`selectCurrency` is `undefined` in `Widgets`. Let's fix this by creating an
action creator.

### Creating an Action Creator

We need an action creator that will build the action object we pass to
`store.dispatch`. Look in the `Widget` component again. You can see in the
AJAX's success callback that we're using the `selectCurrency` function to create
the action passed to the store's `dispatch` call. Time to write that action
creator.

Open `frontend/actions.js`. This is where our app's action creators will live.
Let's define and export a `selectCurrency` function that takes as arguments a
`baseCurrency` string and a `rates` object. It returns an action (i.e. a POJO)
with the following keys and values:

- `type: "SWITCH_CURRENCY"`
- `baseCurrency`
- `rates`

Set it temporarily on the window (`window.selectCurrency = selectCurrency`) and
make sure it's working properly in the console before moving on.

### Creating the `reducer`

Open `frontend/reducer.js`. As you know from the [reducers reading][reducers-reading], a reducer is a function that takes in the current `state` and an `action`, and returns an updated state based on the action type.

[reducers-reading]: ../../readings/reducers.md

For our currency widget, our state needs to keep track of two things: a base currency and a collection of corresponding rates. We need to pass some initial/default values in the case that state is not passed in.

```js
const initialState = {baseCurrency: "Please select", rates: {}};
```

We currently have defined a dummy reducer which always returns the `initialState`. Now let's build it out by adding a `switch` statement. It's going to start by looking something like this:

```js
const reducer = (state = initialState, action) => {
  switch(action.type) {
    default:
      return state;
  }
};

export default reducer;
```

Don't forget the export statement!

Right now, we're returning the same state that is passed in. What we want to do is see if the `action.type` matches something we expect (e.g. `"SWITCH_CURRENCY"`) and return an updated version of the state accordingly. Add a `case` statement to check for this action type. It should return a new object with the correct properties. We can grab those off the action (i.e. `action.rates` and `action.baseCurrency`).

At this point, we have created a Redux store that dispatches actions and responds to dispatched actions. Let's put the reducer on the window (`window.reducer = reducer`) and then test it out in the browser console. Pass a test case to the reducer and make sure it returns what we're expecting. For example,

```js
let action = {
  type: "SWITCH_CURRENCY",
  baseCurrency: "test",
  rates: {"AUD": 3, "USD": 2, "JPY": 5}
};
reducer(null, action) //=> {baseCurrency: "test", rates: {"AUD": 3, "USD": 2, "JPY": 5}}
```

Perfect! Make sure to remove the reducer from the window once you're done testing it.

If you refresh the `index.html` page, you should have a working currency converter!

## Phase 2: Bonus!

Add another component that uses the data in the rates `store`.
