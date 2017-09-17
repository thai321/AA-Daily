import React from 'react';
import { connect } from 'react-redux';

import { Route, withRouter, Redirect } from 'react-router-dom';

const Auth = ({ component: Component, path, loggedIn }) => {
  // const Auth = props => {
  // props = Object(path: '/login', match: Object, location: Object,
  // history: Object, component: function, loggedIn: false)
  // debugger;
  return (
    <Route
      path={path}
      render={props =>
        !loggedIn ? <Component {...props} /> : <Redirect to="/" />}
    />
  );
};

const mapStateToProps = state => {
  return {
    loggedIn: Boolean(state.session.currentUser)
  };
};

export const AuthRoute = withRouter(connect(mapStateToProps, null)(Auth));
