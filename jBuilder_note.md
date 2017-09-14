# Jbuilder/ Normalize


-----
## Common Bugs
- Forgetting to export jsx components
- Importing (curly braces or no curly bracers?)
- 404 Not Found (Check server log. check routes.)
- 500 Internal server issue (Check server log. Check params. Check controller.)
- **View**: Can't read property x of underfined (need default state in reducer)


-----
## jbuilder
- `extract!`
- `set!`
- `array!`
- ` partial!`


```ruby
json.extract! @post, :id, :title, :content, :published_at

json.set! :author do
  json.set! :name, 'David'
end
# => {'author': { 'name': 'David'} }

json.array! @comments do |comment|
  ...


  json.boby comment.body

  json.author do
    json.first_name comment.author.first_name
    json.last_name comment.author.last_nanme
  end
end

# => [ {'body': 'great post...'} 'author': { 'first_name': .., 'last_name': ..}]

```

```ruby

# >todo.json.jbuilder
json.extract! todo, :id, :title, :body, :done, :steps
# => { id:1, title, '', body: .., done: ..., steps: .. }

json.setp2 todo.setps
json.setp3 do
  json.array! todo.steps
end
json.tags todo.tags
json.user todo.user

# index.json.jbuilder
json.partial! '/api/todos/todo', todo: @todo

@todos.each do |todo|
  json.set! todo.id do
    json.partial! 'todo', todo: todo
  end
end
```


```ruby
def index
  @todos = Todo.all
  render :index
end

def show
  @todo = Todo.find(params[:id])
  render :show
end
```


-----
## Advise
- State Shape (A Slice for every Table!)
- Take what you need ... and only what you need.


-----

## State Shape

```ruby
# index.json.jbuilder

json.array! @chrips do |chirp|
  #json.extract! chirp, :id, :body, :author_id

  json.id chirp.id
  json.body chirp.body
  json.author_id chirp.author_id
  json.likes chirp.likes.count
  json.liked_by_current_user  !!chirp.likes.find_by(user_id: current_user.id)
end

# Or create a partial

#_chirp.json.jbuilder
json.extract! chirp, :id, :body, :author_id
json.likes chirp.likes.count
json.liked_by_current_user  !!chirp.likes.find_by(user_id: current_user.id)


# Then go to index.json.builder
json.array! chirps do |chirp|
  json.partial! 'api/chirps/chirp' chirp: chirp
end

# show.json.builder
json.partial! 'api/chirps/chirp', chrip: @chirp


# Actual data
[
  {
    id: 1,
    body: '',
    author_id: 1,
    "likes": 2
    liked_by_current_user: false
  },
  {
    ...
  }
  ...

]
```

------


```js
{
  entities: {
    images: {
      byId: {
        1: {
          id: 1,
          image_url: 'something.com',
          tagIds: [1]
        }

        2: {
          id: 2,
          image_url: 'something.com',
          tagsIds: [1]
        }
      },
      ids: [2,1]
    },

    tags: {
      byId: {
        1: {«»
          id: 1,
          name: 'themed tag'
        }
      },
      ids[1]
    }
  }
}


// reducer
case RECEIVE_Single_chirp:


// Session.js
const defaultState = {
  id: '',
  username: '',
  email: ''
};

f
```
