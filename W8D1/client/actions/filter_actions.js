import { fetchBenches } from '../util/bench_api_util';

export const UPDATE_BOUNDS = 'UPDATE_BOUNDS';

export const updateBounds = bounds => ({
  type: UPDATE_BOUNDS,
  bounds
});

// export const updateFilter = bounds => dispatch =>
//   fetchBenches(bounds).then(benches => dispatch(receiveFilter()));
