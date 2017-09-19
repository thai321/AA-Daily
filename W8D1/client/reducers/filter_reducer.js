import { UPDATE_BOUNDS, UPDATE_FILTER } from '../actions/filter_actions';

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

    case UPDATE_FILTER:
      const newFilter = {
        [action.filter]: action.value
      };
      return Object.assign({}, state, newFilter);
    default:
      return state;
  }
};

export default FilterReducer;
