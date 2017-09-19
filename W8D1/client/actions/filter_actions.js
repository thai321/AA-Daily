import { fetchBenches } from './bench_actions';

import { receiveBenches } from './bench_actions';

export const UPDATE_BOUNDS = 'UPDATE_BOUNDS';
export const UPDATE_FILTER = 'UPDATE_FILTER';

export const updateBounds = bounds => ({
  type: UPDATE_BOUNDS,
  bounds
});

export const changeFilter = (filter, value) => ({
  type: UPDATE_FILTER,
  filter,
  value
});

// export const updateFilter = bounds => dispatch =>
//   fetchBenches(bounds).then(benches => dispatch(receiveFilter()));

export const updateFilter = (filter, value) => (dispatch, getState) => {
  console.log(getState().ui.filters);
  dispatch(changeFilter(filter, value));
  return fetchBenches(getState().ui.filters)(dispatch);
};
