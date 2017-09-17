import { combineReducers } from 'redux';

import FilterReducer from './filter_reducer';

export default combineReducers({
  filters: FilterReducer
});
