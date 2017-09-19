import React from 'react';

import BenchIndexItem from './bench_index_item';
import { updateFilter } from '../../actions/bench_actions';

class BenchIndex extends React.Component {
  // componentDidMount() {
  //   this.props.fetchBenches();
  // }

  render() {
    if (Object.keys(this.props.benches).length === 0) {
      return (
        <div>
          <h2>Loading...</h2>
        </div>
      );
    }

    const benches = this.props.benches.map(bench => (
      <BenchIndexItem key={bench.description} bench={bench} />
    ));

    return (
      <div>
        <ul>{benches}</ul>
      </div>
    );
  }
}

export default BenchIndex;
