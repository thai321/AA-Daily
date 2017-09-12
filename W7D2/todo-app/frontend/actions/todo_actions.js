import * as APIUtil from '../util/todo_api_util';

export const RECEIVE_TODOS = 'RECEIVE_TODOS';
export const RECEIVE_TODO = 'RECEIVE_TODO';
export const REMOVE_TODO = 'REMOVE_TODO';
export const UPDATE_TODO = 'UPDATE_TODO';
export const FETCH_TODOS = 'FETCH _TODOS';

export const receiveTodos = todos => ({
  type: RECEIVE_TODOS,
  todos
});

export const receiveTodo = todo => {
  return {
    type: RECEIVE_TODO,
    todo
  };
};

export const removeTodo = todo => ({
  type: REMOVE_TODO,
  todo
});

export const updateTodo = todo => ({
  type: UPDATE_TODO,
  todo
});

export const fetchTodos = () => dispatch =>
  APIUtil.getTodos().then(todos => dispatch(receiveTodos(todos)));

export const createTodo = todo => dispatch =>
  APIUtil.postTodo(todo).then(todo => dispatch(receiveTodo(todo)));
