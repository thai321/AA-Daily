import React from 'react';

const TodoListItem = ({ todo, removeTodo }) => {
  function handleRemove() {
    removeTodo(todo);
  }

  return (
    <div>
      <li>
        {todo.title}
        <button onClick={handleRemove}>remove</button>
      </li>
    </div>
  );
};

export default TodoListItem;
