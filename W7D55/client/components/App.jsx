import React from 'react';
import { Route, Link } from 'react-router-dom';

import GreetingContainer from './greeting/greeting_container';
import SessionFormContainer from './session_form/session_form_container';

import { AuthRoute } from '../util/route_util';

const App = () => (
  <div>
    <header>
      <h1>Bench BnB</h1>
      <Link to="/">
        <h1>Bench BnB</h1>
      </Link>
      <GreetingContainer />
    </header>

    <AuthRoute path="/login" component={SessionFormContainer} />
    <AuthRoute path="/signup" component={SessionFormContainer} />
  </div>
);

export default App;
