const thunk = ({ dispatch, getState }) => next => action => {
  if (typeof action === 'function') {
    return action(dispatch, getState); // return action and pass to reducer OR pass to reducer
  }

  return next(action); // next middleware function
};

export default thunk;
