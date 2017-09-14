import React from 'react';

class PokemonIndex extends React.Component {
  constructor(props) {
    super(props);

    this.displayPokemon = this.displayPokemon.bind(this);
  }

  // built-in from react
  componentDidMount() {
    this.props.requestAllPokemon();
  }

  displayPokemon() {
    const pokemon = this.props.pokemon.map(poke =>
      <li key={poke.name}>
        <h2>
          {poke.name}
        </h2>
        <img src={poke.image_url} />
      </li>
    );

    return pokemon;
  }

  render() {
    return (
      <div>
        <ul>{this.displayPokemon()}</ul>li>)}
      </div>
    );
  }
}

export default PokemonIndex;
