# Front End Auth

--------
## Demo!


```js
export const postUser = (user) => {
  return $.ajax({
    url: 'api/users',
    method: 'POST',
    data: { user }
  });
};

export const postSession = (user) => {
  return $.ajax({
    url: '/api/session',
    method: 'POST',
    data: { user }
  });
};

export const deleteSession = () => {
  return $.ajax({
    rul: 'api/session',
    method: 'DELETE'
  });
};



```
-------

### Session create (login --> show) and show json.jbuilder

```ruby
class Api::UserController < ApplicationController
  def create
    @user = User.new(user_params)

    if@user.save
      login!(@user)
      render :show
    else
      render json: @user.errors.full_messages, status: 401
    end
  end
end


# show.json.jbuilder
json.extract! @user, :username, :id, :email

```
-----

### Actions


```js
// import {....} from .

export const RECEIVE_CURRENT_USER = 'RECEIVE_CURRENT_USER';
export const LOGOUT_CURRENT_USER = 'LOGOUT_CURRENT_USER';

const receiveCurrentUser = user => ({
  type: RECEIVE_CURRENT_USER,
  user
});


const logoutCurrentUser = () => ({
  type: LOGOUT_CURRENT_USER
});


export const createNewUser = formUser => dispatch => {
  return postUser(formUser).then(user => dispatch(receiveCurrentUser));
};

export const login = formUser => dispatch => {
  return postSession(formUser).then(user => dispatch(receiveCurrentUser(user)));
};

export const logout = () => dispatch => {
  return deleteSession().then(() => dispatch(logoutCurrentUser()));
};


```
----

### Session reducer

```js

import { RECEIVE_CURRENT_USER, LOGOUT_CURRENT_USER}  from '../actions/actions';

const _nullSession = {
  currentUser: null
};

export default (state = _nullSession, action) => {
  Object.freeze(state);

  switch (action.type) {
    case RECEIVE_CURRENT_USER:
      const currentUser = action.user
      return Object.assign({}, { currentUser })
      // Object.assign over write
      // below are fine to use
      // return Object.assign({}, state, { currentUser })
      // return { currentUser }

      // Object.assign({}, state) --> make a copy of state

    case LOGOUT_CURRENT_USER:
      return _nullSession;
    default:
      return state;
  }
};

```


-----

## signup_continer.jsx


```js
import React from 'react';
import { connect } from 'react-redux';
import { createNewUser } from '../../actions/session';
import Signup from './signup';


const mapDispathToProps = (dispatch) => ({
  createNewUser: formUser => dispatch(createNewUser(formUser)),
})

export default connect(undefined, mapDispathToProps)(Signup);
```


-----

## app.jsx

```js
export default () => (
  <div>

  <Route path="/" component={NavBarContainer} />
  <Route exact path="/" component={Home} />
  <AuthRoute path="/signup" component={SignupContainner} />
  <AuthRoute path="/login" component={LoginContainner} />
  <ProtectedRoute path="/chirps" component={ChripIndexContainner} />
  </div>
)
```


----

## signup.jsx

```js
class Signup extends REact.Component {
  constructor(props) {
    super(props);

    this.state = ({

    })

    this.handleSubmit = this.handleSubmit.bind(this);

  }

  handleInput(type) {
    return (e) => {
      this.setState({ [type]: e.target.value })
    }
  }

  handleSubmit(e) {
    e.preventDefault();
    this.props.createNewUser(this.state)
      .then(() => this.props.history.push('/chirps'));
      // redirect to /chirps page
  }


  render() {
    return (
      <div className="session-form">
        <h2>
    )
  }
}
```


-----

## Trick: application.html.erb

```erb

<% if current_user %>
  <script>
    windows.currentUser = {
      'id': "<%= current_user.id %>",
      'username': "<%= current_user.username %>",
      'email': "<%= current_user.email %>"
    };
  </script>
<% end %>

```


-----

## entry.jsb

```js

document.addEve

let preloadedState = undefined;

if(window.currentUser) {
  preloadedState = {
    session: {
      currentUser: window.currentUser
    }
  };
}

const store = createStore(preloadedState)

```



-----

## nav_bar.jsx

```js
export default ({currentUser, logout}) => {
  const display = currentUser? (
    <div>
      <h3> Welcome {currentUser.username}! </h3>
      <button onClick={logout}>Logout</button>
    </div>
  ) : (
    <div>
      <Link className="btn" to='/signup'>Sign Up</Link>
      <Link className="btn" to='/login'>Log In</Link>
    </div>
  );
  return (
    <header className='nav_bar'>
  )
}
```


-----

## route_util.jsx

```js
import React from 'react';
import { connect } from 'react-redux';
import { Redirect, Route, withRouter } from 'react-router-dom';

const mapStateToProps = state => ({
  loggedIn: Boolean(state.session.currentUser)
})

const Auth = ({ component: Component, path, loggedIn }) => (
  <Route path={path} render={(props) => (
    loggedIn ? <Redirect to='/' /> : <Component {...props} />
  )} />
);

const Protected = ({ component: Component, path, loggedIn }) => (
  <Route path={path} render={(props) => (
    loggedIn ? <Component {...props} /> : <Redirect to="/signup" />
  )}
);
// {...props} give us key/value pair


export const AuthRoute = withRouter(connect(mapStateToProps)(Auth));

export const ProtectedRoute = withRouter(connect(mapStateToProps)(Protected));
```



-----

## Quiz

- Q1: on the frontedn, how would we prevent a user who isn't logged in from viewing the index page?
  - Render f functinal component that willco tron...



- Q2: How can we set up a preloadedState to know who our curretn_user id?
  - set current_user on the window
  - User localStorage to store current_user
  - Make an Ajax request to fetchCurrentUser upon entering the root route

- Q3: we must remember to manually include the form authentication token when sending form data with an Ajax re in a Rails app
  - False


----

StyleSheet originize: maintainable css

always do reset

Util: 1 file all
  - Button
  - Chirps: chirip_index, chrip_item


1. Auth
2. Api Utils
3. Actions
  - constants
  - action constants

3. thunk action components
4. Reducers
5. Container --> display/presentation

Index_container --> index --> index_items


----

## Redux history
