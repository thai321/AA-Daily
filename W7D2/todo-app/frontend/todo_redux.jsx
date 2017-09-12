import React from 'react';
import ReactDOM from 'react-dom';
import store from './store/store';
import Root from './components/root';

import { receiveTodos, receiveTodo, removeTodo } from './actions/todo_actions';
import { allTodos } from './reducers/selectors';

document.addEventListener('DOMContentLoaded', () => {
  const content = document.getElementById('content');
  window.store = store;
  window.receiveTodos = receiveTodos;
  window.receiveTodo = receiveTodo;
  window.removeTodo = removeTodo;
  window.allTodos = allTodos;
  ReactDOM.render(<Root store={store} />, content);
});
