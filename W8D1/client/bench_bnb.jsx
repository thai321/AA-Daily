import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';

import Root from './components/root';
import * as SessionUtil from './util/session_api_util';
import * as BenchUtil from './util/bench_api_util';

import * as Actions from './actions/session_actions';

document.addEventListener('DOMContentLoaded', () => {
  const root = document.getElementById('root');

  let store;
  if (window.currentUser) {
    const preloadedState = {
      session: { currentUser: window.currentUser }
    };

    store = configureStore(preloadedState);
    delete window.currentUser;
  } else {
    store = configureStore();
  }

  window.getState = store.getState;
  window.dispatch = store.dispatch;

  window.Actions = Actions;

  window.SessionUtil = SessionUtil;
  window.BenchUtil = BenchUtil;

  ReactDOM.render(<Root store={store} />, root);
});
