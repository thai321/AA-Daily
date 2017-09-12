import { connect } from 'react-redux';
import TodoList from './todo_list';
import {
  receiveTodo,
  removeTodo,
  updateTodo
} from '../../actions/todo_actions';

// state avaliable for TodoList
const mapStateToProps = state => ({
  todos: allTodos(state)
});

// action function avaliable for TodoList
const mapDispatchToProps = dispatch => ({
  receiveTodo: todo => dispatch(receiveTodo(todo)),
  removeTodo: todo => dispatch(removeTodo(todo)),
  updateTodo: todo => dispatch(updateTodo(todo))
});

export default connect(mapStateToProps, mapDispatchToProps)(TodoList);
