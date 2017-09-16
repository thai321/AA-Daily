import { RECEIVE_CURRENT_USER } from '../actions/session_actions';

const _nullSession = {
  currentUser: null
};

const SessionReducer = (state = _nullSession, action) => {
  Object.freeze(state);
  switch (action.type) {
    case RECEIVE_CURRENT_USER:
      const currentUser = action.user;
      return Object.assign({}, state, { currentUser });
    default:
      return state;
  }
};

export default SessionReducer;
