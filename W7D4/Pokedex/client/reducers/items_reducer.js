import { RECEIVE_A_POKEMON } from "../actions/pokemon_actions";
import { merge } from "lodash";

const itemsReducer = (state = {}, action) => {
  Object.freeze(state);
  switch (action.type) {
    case RECEIVE_A_POKEMON:
      const newState = merge({}, state);
      action.pokemon.items.forEach(item => {
        newState[item.id] = item;
      });

      return newState;
    default:
      return state;
  }
};

export default itemsReducer;
