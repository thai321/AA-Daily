export const getTodos = () => {
  return $.ajax({
    method: 'GET',
    url: '/api/todos'
  });
};

export const postTodo = todo => {
  return $.ajax({
    method: 'POST',
    url: '/api/todos',
    data: { todo }
  });
};

export const updateTodo = todo => {
  return $.ajax({
    method: 'PATCH',
    url: `/api/todos/${todo.id}`,
    data: { todo }
  });
};

export const deleteTodo = todo => {
  return $.ajax({
    method: 'DELETE',
    url: `/api/todos/${todo.id}`
  });
};
