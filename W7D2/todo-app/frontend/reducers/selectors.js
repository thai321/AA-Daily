export const allTodos = state =>
  Object.keys(state.todos).map(id => state.todos[id]);
