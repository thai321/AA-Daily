import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';

import Root from './components/root';

document.addEventListener('DOMContentLoaded', () => {
  const preloadedState = localStorage.state
    ? JSON.parse(localStorage.state)
    : {};
  let store = configureStore(preloadedState);

  // store.dispatch = addLoggingToDispatch(store);

  // store = applyMiddlewares(store, addLoggingToDispatch);

  const root = document.getElementById('content');
  ReactDOM.render(<Root store={store} />, root);
});

// Phase 1: Logging
/*
Write a new function addLoggingToDispatch that receives the store as an argument
Save store.dispatch as a local variable
Return a function that receives an action as an argument
Log store.getState() - this is the old state
Log the action
Call your local copy of store.dispatch, passing it the action
Log store.getState() again - this is the new state
Inside the "DOMContentLoaded" callback reassign store.dispatch to your new function, passing in the store
*/
// const addLoggingToDispatch = store => {
//   const dispatch = store.dispatch;
//
//   return action => {
//     console.log('state (before action): ', store.getState());
//     console.log('action: ', action);
//     dispatch(action);
//     console.log('state (after action): ', store.getState());
//   };
// };

// Phase 2: Refactoring
/*
In order to do this, we'll have to turn our addLoggingToDispatch function into a middleware:

addLoggingToDispatch should return a function that receives the next middleware as an argument.
This inner function will return yet another function that receives the action
Inside all of this we will need to do the logging and invoke the next middleware with the action
*/

// const addLoggingToDispatch = store => next => action => {
//   console.log('state (before action): ', store.getState());
//   console.log('action: ', action);
//   next(action);
//   console.log('state (after action): ', store.getState());
// };

// const applyMiddlewares = (store, ...middlewares) => {
//   let dispatch = store.dispatch;
//
//   middlewares.forEach(middleware => {
//     dispatch = middleware(store)(dispatch);
//   });
//
//   return Object.assign({}, store, { dispatch });
// };
