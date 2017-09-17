import React from 'react';
import { Route, Link } from 'react-router-dom';

import { AuthRoute } from '../util/route_util';

import GreetingContainer from './greeting/greeting_container';
import SessionFormContainer from './session_form/session_form_container';
// import BenchIndexContainer from './bench_main/bench_index_container';

import SearchContainer from './search/search_container';

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
    <Route exact path="/" component={SearchContainer} />
  </div>
);

export default App;
