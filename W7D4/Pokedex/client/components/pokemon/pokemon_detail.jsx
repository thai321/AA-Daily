import React from 'react';
import { Route } from 'react-router-dom';

import ItemDetailContainer from '../items/item_detail_container';
import Item from '../items/item';

class PokemonDetail extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    // call once 1st it's mounted
    const id = this.props.match.params.pokemonId;
    // debugger;
    this.props.requestSinglePokemon(id);
  }

  componentWillReceiveProps(newProps) {
    // call every time get request
    const nextId = newProps.match.params.pokemonId;
    const currentId = this.props.match.params.pokemonId;

    if (nextId !== currentId) {
      this.props.requestSinglePokemon(nextId);
    }
  }

  render() {
    if (!this.props.pokemon)
      return (
        <div id="loading-pokeball-container">
          <div id="loading-pokeball" />
        </div>
      );

    const { id, name, image_url } = this.props.pokemon;
    const { items } = this.props;

    return (
      <div>
        <Route
          path="/pokemon/:pokemonId/item/:itemId"
          component={ItemDetailContainer}
        />;
        <h3>{id}</h3>
        <h3>{name}</h3>
        <img src={image_url} />
        <ul>{items.map(item => <Item item={item} />)}</ul>
      </div>
    );
  }
}

export default PokemonDetail;

// <li>
//   <img src={item.image_url} />
// </li>
