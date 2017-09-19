import * as BenchApi from '../util/bench_api_util';
// import { fetchBenches } from '../util/bench_api_util';

export const RECEIVE_BENCHES = 'RECEIVE_BENCHES';

export const receiveBenches = benches => ({
  type: RECEIVE_BENCHES,
  benches
});

export const fetchBenches = filter => dispatch =>
  BenchApi.fetchBenches(filter).then(benches =>
    dispatch(receiveBenches(benches))
  );
