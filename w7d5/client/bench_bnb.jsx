import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';

import Root from './components/root';
import * as Util from './util/session_api_util';
import * as Actions from './actions/session_actions';

document.addEventListener('DOMContentLoaded', () => {
  const root = document.getElementById('root');

  const store = configureStore();
  window.getState = store.getState;
  window.dispatch = store.dispatch;

  window.Actions = Actions;
  window.Util = Util;
  ReactDOM.render(<Root store={store} />, root);
});
