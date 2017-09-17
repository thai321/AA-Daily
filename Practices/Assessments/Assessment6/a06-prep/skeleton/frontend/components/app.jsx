import React from 'react';
import { Route, Switch } from 'react-router-dom';

import PostIndexContainer from './posts/post_index_container';
import PostShowContainer from './posts/post_show_container';
import PostFormContainer from './posts/post_form_container';

// NB: this file is complete - you do not to write/edit anything!
const App = () => (
  <div>
    <h1>A06</h1>
      <Switch>
        <Route exact path="/" component={PostIndexContainer}/>
        <Route exact path="/posts/:postId" component={PostShowContainer}/>
        <Route path="/posts/:postId/edit" component={PostFormContainer}/>
      </Switch>
  </div>
);

export default App;
