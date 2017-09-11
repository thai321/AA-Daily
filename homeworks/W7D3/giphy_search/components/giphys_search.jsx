import React from 'react';

import GiphysIndex from './giphys_index';

class GiphysSearch extends React.Component {
  constructor() {
    super();
    this.state = { term: '' };

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(event) {
    this.setState({ term: event.target.value });
  }

  handleSubmit(event) {
    event.preventDefault();
    const termInURL = this.state.term.split(' ').join('+');
    this.props.fetchSearchGiphys(termInURL);
  }

  render() {
    const { term } = this.state;
    const { giphys } = this.props;
    return (
      <div>
        <h1>Giphy Search</h1>

        <input
          onChange={this.handleChange}
          value={term}
          className="search-bar"
          placeholder="Enter a Search here"
        />
        <button type="submit" onClick={this.handleSubmit}>
          Search Giphy
        </button>

        <GiphysIndex giphys={giphys} />
      </div>
    );
  }
}

export default GiphysSearch;
