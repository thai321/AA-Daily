import { values } from "lodash";

export const selectAllPokemon = state => values(state.entities.pokemon);

export const selectPokemonItem = (state, itemId) => state.entities.items[itemId];
