import React from "react";
import ReactDOM from "react-dom";

import { HashRouter, Route } from "react-router-dom";

import configureStore from "./store/store";
import Root from "./components/root";

import { fetchAllPokemon } from "./util/api_util";
import {
  receiveAllPokemon,
  requestAllPokemon,
  requestSinglePokemon
} from "./actions/pokemon_actions";
import { selectAllPokemon } from "./reducers/selectors";

document.addEventListener("DOMContentLoaded", () => {
  const root = document.getElementById("root");
  const store = configureStore();

  window.getState = store.getState;
  window.dispatch = store.dispatch;
  window.requestAllPokemon = requestAllPokemon;

  window.selectAllPokemon = selectAllPokemon;
  window.requestSinglePokemon = requestSinglePokemon;

  window.fetchAllPokemon = fetchAllPokemon;
  window.receiveAllPokemon = receiveAllPokemon;
  ReactDOM.render(<Root store={store} />, root);
});
