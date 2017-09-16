import * as Util from '../util/session_api_util';

export const RECEIVE_CURRENT_USER = 'RECEIVE_CURRENT_USER';
export const RECEIVE_SESSION_ERRORS = 'RECEIVE_SESSION_ERRORS';

export const receiveCurrentUser = user => ({
  type: RECEIVE_CURRENT_USER,
  user
});

export const receiveErrors = errors => ({
  type: RECEIVE_SESSION_ERRORS,
  errors
});

export const login = formUser => dispatch => {
  return Util.login(formUser).then(user => dispatch(receiveCurrentUser(user)));
};

export const logout = () => dispatch => {
  return Util.logout().then(() => dispatch(receiveCurrentUser(null)));
};

export const signup = formUser => dispatch => {
  return Util.signup(formUser).then(user => dispatch(receiveCurrentUser(user)));
};
