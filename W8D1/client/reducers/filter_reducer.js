import { UPDATE_BOUNDS } from '../actions/filter_actions';

// const _defaultFilter = {
//   bounds: {}
// }

const FilterReducer = (state = {}, action) => {
  Object.freeze(state);
  switch (action.type) {
    case UPDATE_BOUNDS:
      // const newFilter = {};
      // return Object.assign({}, state);
      return action.bounds;
    default:
      return state;
  }
};

export default FilterReducer;
