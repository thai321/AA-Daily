import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import Root from './components/root';

//Phase I: Redux Cycle
// import { fetchSearchGiphys } from './util/api_util';
// import {
//   receiveSearchGiphys,
//   fetchSearchGiphys
// } from './actions/giphy_actions';

document.addEventListener('DOMContentLoaded', function() {
  //Phase I: Redux Cycle
  // window.store = store;
  // window.fetchSearchGiphys = fetchSearchGiphys;
  // window.receiveSearchGiphys = receiveSearchGiphys;

  const store = configureStore();
  ReactDOM.render(<Root store={store} />, document.getElementById('root'));
});

//Phase I: Redux Cycle
// fetchSearchGiphys('puppies').then(res => console.log(res.data));
