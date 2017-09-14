import { connect } from "react-redux";
import { selectAllPokemon } from "../../reducers/selectors";
import { requestAllPokemon } from "../../actions/pokemon_actions";

import PokemonIndex from "./pokemon_index";

const mapStateToProps = state => ({
  pokemon: selectAllPokemon(state)
});

const mapDispatchToProps = dispatch => ({
  requestAllPokemon: () => dispatch(requestAllPokemon())
});

export default connect(mapStateToProps, mapDispatchToProps)(PokemonIndex);
