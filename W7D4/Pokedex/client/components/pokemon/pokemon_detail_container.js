import { connect } from "react-redux";
import PokemonDetail from "./pokemon_detail";
import { requestSinglePokemon } from "../../actions/pokemon_actions";

const mapStateToProps = (state, ownProps) => {
  // const id = ownProps.match.params.pokemonId; //from url
  const displayId = state.ui.pokeDisplay;
  const currentPoke = state.entities.pokemon[displayId];
  let items = [];

  if (currentPoke) {
    const item_ids = currentPoke.item_ids;
    items = item_ids.map(id => state.entities.items[id]);
  }

  return {
    pokemon: currentPoke,
    items
  };
};

const mapDispatchToProps = dispatch => ({
  requestSinglePokemon: id => dispatch(requestSinglePokemon(id))
});

export default connect(mapStateToProps, mapDispatchToProps)(PokemonDetail);
