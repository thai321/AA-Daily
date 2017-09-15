# React-Router


## Learning Goals
- Understand the differenc ebetween static and dynamic router
- ...


-----
## Static VS Dynamic Routing
- **Static Routing**: routes are declared as part of app's initialization before any rendering takes place
  - Rails backend routes follow this convention
  - All versions before React Router v4 are considered static routing
- **Dynamic Routing**: routes are defined as the app is rendering, not in a configuration or convention outside of a running app
  - routes are now defined as part of the React component
  - If the component doesn't mount- the routes virtually doesn't exist

----
## React Router V4 Philosophy
- Routes are useful way to jump from a specific locaiton to another without having to navigate your site manually
  - Gives React component access to the window's location and history
- Emphasis no longer on router, but on React
  - Routing Shouldn't be a static configuation outside of React- they should just be React components
- API small enough to remember without looking at the docs - you learn it once, you learn it all
  - Web
  - Mobile

----
## Fundamental API

### Router
- BrowserRouter
  - HTML5 browser
- HashRouter
  - legacy browsers
- MemoryRouter
  - Testing + non-browser environment
- NativeRouter
- Static Router
  - server-side rendering
- Typically lives at the top level of the React app (nested directly under ***Provider***)


----
## Route
- the building blocks of React Router
- used to determine what UI to render when the location matches the route's path
- A route ALWAYS renders - but when the location does not match, it will render null
- path always starts with a /
- **exact** property ensures the apth is an exact match - as opposed to default behavior
- Three ways to render - only choose one
  - **component**: uses React.createelement to construct given React component
  - **render**: uses inline function to construct a React component
  - **Children**: works like, render, but gets called regardless of whether there's a match

----
## Route Props
1. **match**
  - params, isExact, path, url
2. **location**
  - immutable Javascript object that represents window's current state
3. **history**
  - mutable javaScript object
  - push, replace, go(n), block(prompt)


-----

## Link + Navlink
- To property takes in string or object
- Component that generates an anchor tag to a specific route
  - Possible to do the same thing by installing an onClick handler on a div
    **(this.prop.history.push(x))**
  - more semantic/ readable
- **NavLink** is built on top of Link - adds active styling on the current link of set of links

-----
## Switch
- Will only render the first matching route of the set of nested routes
- Renders the element in the sam eposition by default
- Typically a good idea to render a 404 page or the equivalent in a catch-all route as the last nested route

```js
import {Switch, Route} from 'react-router'

<Switch>
  <Router exact path="/" component={Home}/>
  <Router path="/about" component={About}/>
  <Router path="/:user" component={User}/>
  <Router component={NoMatch}/>
</Switch>
```


-----
## Redirect
- To property takes a string or object to redirect route to
- Push property when present will push onto the history stack, not just replace current entry
- from property can only be used within a Switch statement to redirect from one route to another

------
## WithRouter
- Analogous to the connect from react-redux
  - provides React Router props to the React-Redux component
- required with Redux, because the connect function overwrites defualt shouldComponentUpdate behavior
- Route props can be passed as an argument to mapStateToProps: ownProps

```js
// This gerts around ShouldComponentUpdate
withRouter(connect(...)(MyComponent))

// This does Not
connect(...)(withRouter(MyComponent))
```


```js
// Route props in containner
import React from 'react'
import connect
impor WelcomeBar

const mapstateToProps = (state, ownProps) => ({
  session: state.session[ownProps.match.params[sessionId]]
});

export default withRouter(connect(mapStateToProps)(WelcomeBar))

```


-----
## Code Demo

```js
// entry.jsx
import { HashRouter } from 'react-router-dom';

const Root = () => (
  <HashRouter>
    <App/>
  <HashRouter/>
);


document.addEventListener('DOMContentLoaded', ()=> {


  ReactDOM.render(
    <Root />,
    main
  );
})

```

```js
// index.jsx

export default() => {
  <div>



    <Switch>
      <Route path='pokemon/pikachu' component = {Pikachu} />
      <Route path='pokemon/bulbasaur' render={() => {
        return <Redirect to="/pokemon/pikachu" />;
      }} />


      <Route  path="/pokemon"/>
      <Route render={({match, location}) =>
        <Default match={match}
              location={location}
              extra="more props!"
        /> }  />
    <Switch />
  </div>
}


// pikachu.jsx
export default({match, location, history}) => {
  console.log(match);

  return (
    <div>
      ...
    <div/>
  );
}
}

```


----

# Quiz Solution

- withRouter: Provides this.props.match, this.props.location, this.props.history to the component
