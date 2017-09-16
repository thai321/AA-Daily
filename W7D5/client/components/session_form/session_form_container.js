import { connect } from 'react-redux';

import { login, signup } from '../../actions/session_actions';
import SessionForm from './session_form';

const mapStateToProps = (state, ownProps) => {
  const loggedIn = Boolean(state.session.currentUser);
  const errors = state.errors.session;

  return {
    loggedIn,
    errors
  };
};

const mapDispatchToProps = (dispacth, ownProps) => {
  const formType = ownProps.location.pathname.slice(1);
  const processForm = formType === 'login' ? login : signup;

  return {
    processForm: user => dispacth(processForm(user)),
    formType
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(SessionForm);
