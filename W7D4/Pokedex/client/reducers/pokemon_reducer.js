import { merge } from "lodash";

import {
  RECEIVE_ALL_POKEMON,
  RECEIVE_A_POKEMON
} from "../actions/pokemon_actions";

const pokemonReducer = (state = {}, action) => {
  Object.freeze(state); // shashow
  switch (action.type) {
    case RECEIVE_ALL_POKEMON:
      return action.pokemon;
    case RECEIVE_A_POKEMON:
      const newState = merge({}, state);
      newState[action.pokemon.id] = action.pokemon;
      
      return newState;
    default:
      return state;
  }
};

export default pokemonReducer;
