import { connect } from 'react-redux';
import { values } from 'lodash';

import BenchIndex from './bench_index';

import { fetchBenches } from '../../actions/bench_actions';

const mapStateToProps = state => {
  const benches = values(state.entities.benches);
  return {
    benches,
    state
  };
};

const mapDispatchToProps = dispatch => ({
  fetchBenches: () => dispatch(fetchBenches())
});

export default connect(mapStateToProps, mapDispatchToProps)(BenchIndex);
