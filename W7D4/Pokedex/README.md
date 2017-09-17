# Pokedex: Part 2 - An Introduction to React Router

Check out the live demo [here][live-demo]!

[live-demo]: http://aa-pokedex.herokuapp.com/

## Phase 4: React Router

Now let's say we want the ability to click on any of the listed pokemon and see more details about them.
In order to maintain a common user interface used around the web, we will have the URL define what components the user sees.
This is exactly what the powerful `react-router-dom` package is for.
To use it, navigate to your `pokedex.jsx` file and import the following:

```javascript
import { HashRouter, Route } from 'react-router-dom';
```
Refer to the [react-router-dom documentation][routes-docs] as a reference.

[routes-docs]: https://reacttraining.com/react-router/web/guides/quick-start

### Adding the `Router`

The React-Router `<HashRouter />` component is the primary component which wraps our route hierarchy.
It is responsible for listening for changes to our browser's url.
When the url changes, the `HashRouter` determines which component to render based on which `Route`'s `path` matches the url.

* Wrap the `HashRouter` in your app's `Root` and `Provider`.
Define your `Root` after you've defined `store` (within your `addEventListener` callback).

Your `Root` should now look like this:

```javascript
import { HashRouter, Route } from 'react-router-dom';

const Root = () => (
  <Provider store={store}>
    <HashRouter>
      // primary route will go here
    </HashRouter>
  </Provider>
);
```

### Adding a `Route`

Instead of rendering the `PokemonIndexContainer` directly, setup a root
`Route` that will render the component when `path="/"`. Like so:

```javascript
<Provider store={ store }>
  <HashRouter>
    <Route path="/" component={PokemonIndexContainer} />
  </HashRouter>
</Provider>
```

**Test that your `PokemonIndex` component still renders at your app's
root url**

### `PokemonIndexItem`

Let's refactor your presentational component so that each pokemon object is rendered in a `PokemonIndexItem` component.
As your app grows, refactor components to keep them minimal and modular.

Create a `frontend/components/pokemon/pokemon_index_item.jsx` file and export a functional `PokemonIndexItem` component.
Your `PokemonIndexItem` should return a `li` containing information on a pokemon's `name` and `image_url`.
This information should be served as props. Refactor `PokemonIndex` to utilize this new component.
Your `PokemonIndex` should map each pokemon objects in `this.props.pokemon` to a `PokemonIndexItem`.
It should look something like this:

```javascript
const pokemonItems = pokemon.map(poke => <PokemonIndexItem key={poke.id} pokemon={poke} />);

// And inside the render:
<section className="pokedex">
  <ul>
    {pokemonItems}
  </ul>
</section>
```

**Test your code** to ensure everything still renders as it did before.

Let's add functionality to our app.
Every time a user clicks on a `PokemonIndexItem` we wanted to route them to a `/pokemon/:id` path and render a `PokemonDetail` component.
To see this in action check out the [live demo][live-demo].

* Import `Link` to your `PokemonIndexItem` like so:

  ```javascript
  import { Link } from 'react-router-dom';
  ```

Inside each li, wrap the pokemon information in a `Link` tag.
Give it a `to` prop with the path for the frontend pokemon show page (`/pokemon/:pokemonId`).

The `Link` tag will generate an appropriate link to this path.
While it would be possible to accomplish the same thing with an `a` tag and an `href` property, using React Router's own `Link` tag is less brittle and will do the right thing, even if we use `BrowserRouter` rather than `HashRouter` for example.

While clicking on a `PokemonIndexItem` will change the browser's url, you may have noticed that nothing is happening. We need a `Route` to render when we visit `/pokemon/:pokemonId`. Let's make one.

## Phase 5: `PokemonDetail`

Start by defining that component the `Route` will render: `PokemonDetail`.

Before defining a new component and adding it to your app, you should always plan out where and how it will get its information.
We want the `PokemonDetail` to display a Pokemon's information as well as its `Items`.
Talk over the following questions with your partner:

* Where will the `PokemonDetail` get its information from?
* How will we pass this information to `PokemonDetail`?

Hint: Your state shape will look something like this:

```javascript
// Sample State Shape
{
  entities: {
    pokemon: {
      1: {
        name: Bulbasaur,
        image_url: '/assets/110.png',
      },
      2: {
        name: 'Ivysaur',
        image_url: '/assets/pokemon_snaps/112.png',
        attack: 62,
        defense: 63,
        poke_type: 'grass',
        moves: [
           'tackle',
           'vine whip',
           'razor leaf'
        ],
        item_ids: [3, 4, 5],
      },
      3: {
        name: 'Venusaur',
        image_url: '/assets/130.png',
      },
      //... more pokemon
    },
    items: {
      3: {
        pokemon_id: 2,
        name: 'Berry',
        price: 5,
        happiness: 99,
        image_url: '/assets/pokemon_berry.svg',
      },
      4: {
        pokemon_id: 2,
        name: 'Egg',
        price: 5,
        happiness: 99,
        image_url: '/assets/pokemon_egg.svg',
      },
      5: {
        pokemon_id: 2,
        name: 'Potion',
        price: 5,
        happiness: 99,
        image_url: '/assets/pokemon_potion.svg',
      },
      // ... more items
    }
  },
  ui: {
    pokeDisplay: 2,
    errors: {},
    loading: {},
  }
}
```

Implement the `PokemonDetail` component just like we did the `PokemonIndex`. Make sure to **test at each step!**

* Create an API utility function that fetches a single pokemon.
* Create actions for receiving a single Pokemon.
This requires defining a new constant and action creator.
* Update the `pokemonReducer` to handle receiving a single pokemon.
* Create an `itemsReducer` for an items slice of state. Just like `pokemonReducer` this should also be nested under the `entities` slice of state.
  * Remember: multiple reducers can respond to the same action! How will you add a pokemon's items to state?
* Create a `uiReducer` for a `ui` slice of state to update the pokeDisplay when you receive a single pokemon.
* Create a `requestSinglePokemon` thunk action creator.
* Create a `PokemonDetailContainer` that maps props to `PokemonDetail`.
* Create a class `PokemonDetail` component that returns information of the pokemon.
* Add a `Route` that renders the `PokemonDetailContainer` component when the url matches the path `"/pokemon/:pokemonId`".
  * We'll add the `Route` to the end of our `PokemonIndex` render function.
  * Inside of `PokemonDetail` on `componentDidMount`, call `this.props.requestSinglePokemon`.
  Pass it the pokemon's id from the `this.props.match.params.pokemonId`.

Once it works, try navigating to the route of a different pokemon.
Your detail view won't update.
This is because although the props (`this.props.match.params.pokemonId`) have changed, the component didn't remount.
So we never requested the new pokemon.
We need to trigger a request on the props changing.
There is a lifecycle method we can tap into to accomplish this: `componentWillReceiveProps(newProps)`.

* In your `PokemonDetail` component, on `componentWillReceiveProps(newProps)`, call `this.props.requestSinglePokemon(newProps.match.params.pokemonId)`, but only if  the `pokemonId` has changed.
You can check your current props to find out the previous value.

**Test your `PokemonDetail` redux cycle and route!** Does it behave like
the [live demo][live-demo]? Show a TA before moving on.

## Phase 6: `ItemDetail`

Let's add more functionality and another Route.
When a user clicks on an item from a pokemon's `PokemonDetail`, the router should redirect to a path `/pokemon/:pokemonId/items/:itemId` where an `ItemDetail` component displays information about an `Item` within the `PokemonDetail` component.
This should be implemented without any changes to the application state because items are loaded into the `pokemonDetail` slice of state when a single pokemon is selected.
* Create an `ItemDetailContainer` that receives an item's information as
`props`.
  * When providing the item to the `ItemDetail` component from the `ItemDetailContainer`, remember that `mapStateToProps` accepts a
second parameter `ownProps`.
`ownProps.match.params` returns the params object.
  * Use `ownProps.match.params.itemId` to select the correct item from the `state`.
  * Define a new `selectPokemonItem(state, itemId)` selector and call it in `mapStateToProps`.
* Create a functional `ItemDetail` component that displays its `item` prop.
  * `ItemDetailContainer` connects it to the store.
* Create a new route that renders the `PokemonIndexContainer`, `PokemonDetailContainer` and `ItemDetailContainer` when the path matches `/pokemon/:pokemonId/items/:itemId`.

Hint: nest your new `Route` under the render function of `PokemonDetail`.

Your app's `HashRouter` should contain the following routes:

```javascriptx
// pokedex.jsx
<HashRouter>
  <Route path="/" component={PokemonIndexContainer} />
</HashRouter>

// pokemon_index.jsx
<Route path="/pokemon/:pokemonId" component={PokemonDetailContainer} />

// pokemon_detail.jsx
<Route path="/pokemon/:pokemonId/item/:itemId" component={ItemDetailContainer} />
```

**Test your `ItemDetail` components and route!** Does it behave like the
[live demo][live-demo]? Show a TA before moving on.

## Phase 7: Creating Pokemon

Our next feature will be to allow the creation of new Pokemon. To allow users to create Pokemon, you will need to:

* Define a `#create` controller action for the `PokemonController`.
* Create an API function that sends a single Pokemon's information as part of a `POST` request to the backend.
* Create actions for both creating and receiving a new Pokemon (creation should be a thunk, receiving is a regular action).
* Update the reducer to respond to receiving a new Pokemon.
* Create a `PokemonFormContainer` that only connects `mapDispatchToProps`.
  * Pass a function prop called `createPokemon` that dispatches your `CREATE_POKEMON` action.

**Test at each step!**

### `PokemonForm`

Create a controlled `PokemonForm` component.

Remember, a **controlled component** is one which overrides the default functionality of the browser, allowing your code to entirely control your application.
This is most commonly used in forms to ensure that input field values are being tracked in internal state and that submit buttons perform actions as described by the application.

Use the `constructor()` method to provide a default internal state to your form.
Even though Javascript convention is to use camelCase, it is often easiest to define data in the format our server expects when making a "POST" request.  
In Ruby, this means snake_case.

Normally these constructor functions are taken care of by React.
In this case, we are overriding the constructor function to have a default internal state, so it is our responsibility to make sure all functions are properly bound. Like so:

```javascript
class ControlledComponent extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      //...
    };

    this.exampleMethod = this.exampleMethod.bind(this);
  }
  //...
}
```

For the input elements, use an `onChange` listener and write a single `update` function to call the `setState` method.

An basic example of an `update` method is below:
```javascript
class ControlledComponent extends React.Component {
  //...

  update(property) {
    return e => this.setState({ [property]: e.target.value });
  }

  //...
}
```

The best html element for the Pokemon type is a `<select>` element, which appears to the user as a dropdown.
Copy / paste the array of pokémon types from the model and use it in your `PokemonForm`.

Write a `handleSubmit` method as well that prevents the default event action and instead calls the `createPokemon` function from props.
Make sure to pass this function to the `onSubmit` listener of the form.

We want this form to appear when at the same root path as the `PokemonIndex`, but not at any further nested routes like the `PokemonDetail`.
To do so, we'll add a new `Route` to our `PokemonIndex` and use `exact` prop to only render `PokemonFormContainer`  when the path exactly matches the root path.

**NB**: There are a couple of tricky aspects to getting the form to work properly which will be great debugging practice.
Use a `debugger` in your `postPokemon` function to ensure that you are always passing the correct parameters to your API.

The final parts of the `PokemonForm` are redirecting callback and error handling.

### Redirecting

Once the posting is complete we want the application to redirect to the newly created Pokemon.
We need to wait, however, because we need this Pokemon's ID in order to push to that URL.
We will only have this id after the response has come back from the server, so we can tack on another `.then` after our promise resolves and redirect from there.

Make sure that your `createPokemon` action creator returns the promise and that any `.then` calls you tack onto the end return the pokemon.
The reason for this is that when chaining calls to `then` the return value of the previous is passed as the input to the next.
This can be handy for gradually building up a value, in our case we want to do two things with the same input, so we must pass it through.

Your `createPokemon` should look like this:

```javascript
export const createPokemon = pokemon => dispatch => (
	APIUtil.postPokemon(pokemon).then(pokemon => {
		dispatch(receiveNewPokemon(pokemon));
		return pokemon;
	});
);
```

In order to get the router to send us to a new location from within the component, we can use `react-router-dom`'s `withRouter` function.
`withRouter` is referred to as a **Higher Order Component** (HOC).
Much like our container components, it serves to pass down information (namely the `history`) through props.

* Import `withRouter` to your `PokemonForm` like so:
  ```javascript
  import { withRouter } from 'react-router-dom';
  ```
* Call this function on `PokemonForm` before exporting it like so:
  ```javascript
  export default withRouter(PokemonForm);
  ```

Your `PokemonForm` will now have access to your app's router via `props.history`! We can now use `history.push(path)` to redirect our user to different routes!

On successful submission of your form, redirect the user to the pokemon show page.

```javascript
class PokemonForm extends Component {
  handleSubmit(e) {
    e.preventDefault();
    this.props.createPokemon(this.state).then((newPokemon) => {
      this.props.history.push(`pokemon/${newPokemon.id}`);
    });
  };
}
```

### Error Handling

The server will tell us whether or not our new Pokemon was created successfully.
But so far, we have no way of letting our users know what happened. We need a way of displaying errors on the front-end after an unsuccessful POST request by adding an `errors` slice to our state.

```javascript
// Sample State Shape
{
  pokemon: {
    //...
  },
  pokemonDetail: {
    //...
  },

  errors: [ 'message 1', 'message 2' ]
}
```

* Add a `receivePokemonErrors` action and corresponding constant.
* Add a second argument to the `then` method in your `createPokemon` thunk that dispatches `receivePokemonErrors` passing in `errors.responseJSON`.
* Add a new reducer, `ErrorsReducer`, to handle the `errors` slice to your app state.
* Update the `createPokemon` thunk action creator to use this new action on failure
* Add a `mapStateToProps` function that connects to the `PokemonFormContainer`
* Add an errors function to the `pokemonForm` that returns an unordered list of error messages.
* Add a `mapStateToProps` function in the `PokemonFormContainer` to provide the `PokemonForm` with a list of errors

To test that the errors properly show up, try adding a pokemon with the same name as a pokemon that currently exists in the database.
Pokemon names have a `uniqueness: true` constraint, so it should display an error like "Name is already taken".

## Phase 8: Style

A significant portion of the time you spend working on your full-stack project will involve styling.
You'll need to use HTML and CSS to style your project to look good and like the site you're cloning.
Let's practice that now!

Style your app to look like the [live demo][live-demo]. Our HTML/CSS [curriculum][html-css-curriculum], the [Complete Guide to Flexbox][flexbox-guide], and the internet are good resources if you get stuck! :art:

[html-css-curriculum]: ../../../html-css#htmlcss-curriculum
[flexbox-guide]: https://css-tricks.com/snippets/css/a-guide-to-flexbox/

## Phase 9: Loading Spinner

In this phase we'll create a 'loading' spinner that displays while we're fetching information from the backend.

We've supplied the [CSS][pokeball-css] for a pokeball spinner that you can use.
The css animation requires the following html to function:

```html
<div id="loading-pokeball-container">
  <div id="loading-pokeball"></div>
</div>
```

* Feel free to use the pokeball spinner we've provided.
However, you can also Google "css spinner" to find another spinner to implement!
* Before calling the `APIUtil`, have your async actions also dispatch an action with `type: START_LOADING_ALL_POKEMON` for `requestAllPokemon` and an action with `type: START_LOADING_SINGLE_POKEMON` for `requestSinglePokemon`.
* Create a new reducer, the `loadingReducer`
  * Your `loadingReducer` should care about all `START_LOADING_` and `RECEIVE_` action types
  * When a request is made, change the loading state to `true`, when the data is received, change the state to `false`
* Change your `PokemonIndex` and `PokemonDetail` components to render the spinner if the loading state is `true`

[pokeball-css]: ./skeleton/app/assets/stylesheets/loading-pokeball.scss

## Phase 10: Bootstrap Poketypes

We have a list of pokétypes in two places: our `Pokemon` model and our `PokemonForm` React component.
This is not very dry. Let's employ a tactic called "bootstrapping" to tell our form all the pokémon types.

* Delete the `POKEMON_TYPES` constant from your `PokemonForm` component
* Open `application.html.erb`
  * Add a `<script>` tag; inside, set the value of `window.POKEMON_TYPES` to the `POKEMON_TYPES` constant used in the `PokemonModel`
  * Use the `#raw` method to tell Rails not to escape the symbols in our array
* Update you `PokemonForm` to use `window.POKEMON_TYPES` instead

```javascript
window.POKEMON_TYPES = <%= raw Pokemon::TYPES %>
```

## Bonus: Update Pokemon

Create a new front-end route:

```
/pokemon/:id/edit
```

This route should render an edit page where you can update the properties of your Pokemon!
Refactor your `PokemonForm` component so that it can be used to both create and update Pokemon.
You should only have to make one new action and one new api util function:

* `requestUpdatePokemon` action creator
* `updatePokemon` api util function

But you should have to refactor the following pieces:

* `PokemonFormContainer`
* `PokemonForm`

## Bonus: Update Items

Add the ability to reassign items to different Pokemon. This time, design is up to you!

