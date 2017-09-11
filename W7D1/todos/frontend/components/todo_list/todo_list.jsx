import React from 'react';
import TodoListItem from './todo_list_item';

class TodoList extends React.Component {
  constructor(props) {
    super(props);
    // this.props.todos ==> [...todos]
    // this.props.receiveTodo({id: 5, title: ''}) ==> [...todos]
  }

  render() {
    console.log('props', this.props.todos[0].title);
    return (
      <div>
        <h1>Todo List Component</h1>
        <ul>
          {this.props.todos.map(todo =>
            <TodoListItem key={todo.id + todo.title} todo={todo} />
          )}
        </ul>
      </div>
    );
  }
}

export default TodoList;
