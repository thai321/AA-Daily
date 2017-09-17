import { combineReducers } from 'redux';

import BenchesReducer from './benches_reducer';

export default combineReducers({
  benches: BenchesReducer
});
