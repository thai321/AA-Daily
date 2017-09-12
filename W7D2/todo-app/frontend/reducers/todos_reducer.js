import {
  RECEIVE_TODOS,
  RECEIVE_TODO,
  REMOVE_TODO,
  UPDATE_TODO
} from '../actions/todo_actions';
import merge from 'lodash/merge';

const initialState = {
  1: {
    id: 1,
    title: 'wash car',
    body: 'with soap',
    done: false
  },

  2: {
    id: 2,
    title: 'wash dog',
    body: 'with shampoo',
    done: true
  }
};

const todosReducer = (state = initialState, action) => {
  Object.freeze(state);
  let nextState;

  switch (action.type) {
    case RECEIVE_TODO:
      nextState = merge({}, state);
      nextState[action.todo.id] = action.todo;

      return nextState;
    case RECEIVE_TODOS:
      nextState = {};
      Object.keys(action.todos).map(id => {
        nextState[id] = action.todos[id];
      });

      return nextState;
    case REMOVE_TODO:
      nextState = merge({}, state);
      delete nextState[action.todo.id];
      return nextState;

    case UPDATE_TODO:
      nextState = merge({}, state);
      nextState[action.todo.id] = action.todo;
      // const currentTodo = nextState[action.todo.id];
      // currentTodo.done = action.todo.done;
      return nextState;

    default:
      return state;
  }
};

export default todosReducer;
