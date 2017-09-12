import React from 'react';

const TodoListItem = ({ todo, removeTodo, updateTodo }) => {
  function handleRemove() {
    removeTodo(todo);
  }

  function handleDone() {
    const state = todo.done ? false : true;
    const newTodo = Object.assign({}, todo, { done: state });
    updateTodo(newTodo);
  }

  function displayDone() {
    return todo.done ? 'Undo' : 'Done';
  }

  return (
    <div>
      <li>
        {todo.title}
        <button onClick={handleRemove}>remove</button>
        <button onClick={handleDone}>
          {displayDone()}
        </button>
      </li>
    </div>
  );
};

export default TodoListItem;
