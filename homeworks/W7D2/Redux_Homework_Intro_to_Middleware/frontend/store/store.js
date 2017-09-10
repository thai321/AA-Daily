import { createStore, applyMiddleware } from 'redux';
import RootReducer from '../reducers/root_reducer';

const configureStore = (preloadedState = {}) => {
  const store = createStore(
    RootReducer,
    preloadedState,
    // Phase 3: Redux applyMiddleware
    applyMiddleware(addLoggingToDispatch)
  );
  store.subscribe(() => {
    localStorage.state = JSON.stringify(store.getState());
  });
  return store;
};

/*
_ Import applyMiddleware from redux
_ Move your logging middleware function into this file
_ Add a call to applyMiddleware in your call to createStore
  + Pass in your logging middleware as an argument to applyMiddleware
Then, restore todo_redux.jsx to its original state.
*/

const addLoggingToDispatch = store => next => action => {
  console.log('state (before action): ', store.getState());
  console.log('action: ', action);
  next(action);
  console.log('state (after action): ', store.getState());
};

export default configureStore;
