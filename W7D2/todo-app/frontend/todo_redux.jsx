import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import Root from './components/root';

import {
  receiveTodos,
  receiveTodo,
  removeTodo,
  fetchTodos
} from './actions/todo_actions';
import { allTodos } from './reducers/selectors';

import { getTodos } from './util/todo_api_util';

document.addEventListener('DOMContentLoaded', () => {
  const content = document.getElementById('content');
  const store = configureStore();

  window.store = store;
  window.receiveTodos = receiveTodos;
  window.receiveTodo = receiveTodo;
  window.removeTodo = removeTodo;
  // window.allTodos = allTodos;
  window.fetchTodos = fetchTodos;

  window.getTodos = getTodos;

  ReactDOM.render(<Root store={store} />, content);
});
