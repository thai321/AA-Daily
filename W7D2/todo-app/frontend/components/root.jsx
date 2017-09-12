import React from 'react';
import { Provider } from 'react-redux';

import App from './app';
import TodoListContainer from './todo_list/todo_list_container';

const Root = ({ store }) =>
  <Provider store={store}>
    <div>
      <App />
      <TodoListContainer />
      {/*<TodoDetailViewContainer />*/}
      <h1>hello Kitty</h1>
    </div>
  </Provider>;

export default Root;
