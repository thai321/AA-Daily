import { RECEIVE_A_POKEMON } from "../actions/pokemon_actions";
import { merge } from "lodash";

const uiReducer = (state = {}, action) => {
  Object.freeze(state);
  switch (action.type) {
    case RECEIVE_A_POKEMON:
      return { pokeDisplay: action.pokemon.pokemon.id };
    default:
      return state;
  }
};

export default uiReducer;
