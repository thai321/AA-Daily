import React from 'react';
import ReactDOM from 'react-dom';
import store from './store/store';
import Root from './components/root';

import { receiveTodos, receiveTodo } from './actions/todo_actions';
import { allTodos } from './reducers/selectors';

document.addEventListener('DOMContentLoaded', () => {
  const content = document.getElementById('content');
  window.store = store;
  window.receiveTodos = receiveTodos;
  window.receiveTodo = receiveTodo;
  window.allTodos = allTodos;
  ReactDOM.render(<Root store={store} />, content);
});
