# Middleware W7D2

## Learning Goals
- uderstand the extra stuff
- connect the dots
  - overview of frontend and backed
- understand how thunk middleware works

-----
## Extra Stuff
- import/export & destructuring
  - const{b} = a

```js
export default Thing ---> import Thing from './thing'

export const Thing ---> import {Thing} from './thing'
```


```js
let a = { b: { c: 3 } };
> a
{ b: { c: 3 } }

let { b: { c } } = a;

c --> 3

let { b, b: { c } }  = a;

b --> { c: 3 }
```


------

## Redux Cycle REview
- Management of application state

------
## Backend Structure
- Store information in database

-----
## Full Stack Apps
- Allow interaction and persitant



```ruby
root to: 'static_pages#root'

namespace :api, defaults: {format: :json} do
  resouces: :todos, only: [:...]

  end
end

class StaticPagesController < ApplicationController

end

class Api::ApiCaontroller < ApplicaitonController

end

class Api::Controller < Api::ApplicaitonController
  def index
    render json: Todo.all, include: :tags
  end

  def show
    render json: Todo.find(params[:id]), include: :tags
  end

  def create
    @todo= Todo.new(todo_params)
  end


end
```


-----
## API Utils
- connect backend & frontend using AJAX/HTTP

------
## Middleware
- receives dispatched actions before reducers do

```js
import logger from 'redux-logger';

const configureStore = (preloadedState) = {} =>{


}
```

---
## Thunks
- Defintion: a special (and uncommon name for a function that's returned by another)
- Use case: primarily used to represent an additional process or calcualtion that needs to execute, or to call a routline that does not support the usual calling mechanism


-------
## Thunk Middleware
- pass "normal" actions to reducer
- call 'thunk' (function) actions

### Function Signature
- Input : **store => next => ApplicationController**
- output: **probably call next(action)**

-----
## Thunk Middlware

```js
const thunkMiddlware = ({ dispatch, getState }) => next => action => {
  if (typeof action === 'function') {
    return action(dispatch);
  }
    return next(action) // it's POJO
}

export default thunkMiddleware;
```

----
### API Utils

```js
export const fetchTodos = () => {
  $.ajax({
    method: 'Get'
    url : ...
  })
}
```




```js
//Actions

export const receiveTodos = todos => ({
  type: receiveTodos,
  todos
})



// async -thunk action crator

export const requestTodo =


export const fetchTodos = () => (
  $.ajax({
    method: 'GET',
    url: '/api/todos'
  })
);

// Actions
import * as TodoAPIUTIL

export const RECEIVE_TODOS = 'REVECEIVE_TODOs';

export const receiveTodos = todos =>  ({
  type: RECEIVE_TODOS,
  todos
})



// async - thunk action
export const requestTodos = () => dispatch => (
  TodoAPIUtil.fetchTodos().then(todos => dispatch(receiveTodos(todos)))
)


// requestTodos: () => dispatch(requestTodos())
// requestTodos()

// dispatch => {
//   TodoAPIUtil.fetchTodos().then(todos => dispatch(receiveTodos(todos)));
// }

//Thunk Middleware

const thunkMiddleware = ({dispatch, getState}) => next => action => {
  if(typeof action === 'function') {
    return action (dispatch, getState)
  }

  return next(action)
}
```
