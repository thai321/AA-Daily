import { connect } from 'react-redux';
import TodoList from './todo_list';
import {
  createTodo,
  removeTodo,
  updateTodo,
  fetchTodos,
  deleteTodo
} from '../../actions/todo_actions';
import { allTodos } from '../../reducers/selectors';
// state avaliable for TodoList
const mapStateToProps = state => ({
  todos: allTodos(state), // this return an array
  errors: state.errors
});

// action function avaliable for TodoList
const mapDispatchToProps = dispatch => ({
  createTodo: todo => dispatch(createTodo(todo)),
  deleteTodo: todo => dispatch(deleteTodo(todo)),
  updateTodo: todo => dispatch(updateTodo(todo)),
  fetchTodos: () => dispatch(fetchTodos())
});

export default connect(mapStateToProps, mapDispatchToProps)(TodoList);
