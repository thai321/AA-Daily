import React from 'react';

import TodoListItem from './todo_list_item';
import TodoForm from './todo_form';

class TodoList extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    this.props.fetchTodos();
  }

  render() {
    return (
      <div>
        <h1>Todo List Component</h1>
        {this.props.errors.map((err, idx) =>
          <h2 key={idx + err}>
            {err}
          </h2>
        )}

        <ul>
          {this.props.todos.map(todo =>
            <TodoListItem
              key={todo.id + todo.title}
              todo={todo}
              updateTodo={this.props.updateTodo}
              deleteTodo={this.props.deleteTodo}
            />
          )}
        </ul>
        <TodoForm createTodo={this.props.createTodo} />
      </div>
    );
  }
}

export default TodoList;
