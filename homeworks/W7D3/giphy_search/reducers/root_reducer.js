import { combineReducers } from 'redux';

import GiphysReducer from './giphys_reducer';

export default combineReducers({
  giphys: GiphysReducer
});
