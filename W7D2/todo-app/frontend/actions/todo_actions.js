import * as APIUtil from '../util/todo_api_util';

import { receiveErrors } from './error_actions';

export const RECEIVE_TODOS = 'RECEIVE_TODOS';
export const RECEIVE_TODO = 'RECEIVE_TODO';
export const REMOVE_TODO = 'REMOVE_TODO';

export const FETCH_TODOS = 'FETCH _TODOS';

export const receiveTodos = todos => ({
  type: RECEIVE_TODOS,
  todos // payload
});

export const receiveTodo = todo => {
  return {
    type: RECEIVE_TODO,
    todo // payload
  };
};

export const removeTodo = todo => ({
  type: REMOVE_TODO,
  todo // payload
});

export const fetchTodos = () => dispatch =>
  APIUtil.getTodos().then(todos => dispatch(receiveTodos(todos)));

export const createTodo = todo => dispatch =>
  APIUtil.postTodo(todo).then(
    todo => dispatch(receiveTodo(todo)),
    err => dispatch(receiveErrors(err.responseJSON))
  );

export const updateTodo = todo => dispatch =>
  APIUtil.updateTodo(todo).then(
    todo => dispatch(receiveTodo(todo)),
    err => dispatch(receiveErrors(err.responseJSON))
  );

export const deleteTodo = todo => dispatch =>
  APIUtil.deleteTodo(todo).then(todo => dispatch(removeTodo(todo)));
