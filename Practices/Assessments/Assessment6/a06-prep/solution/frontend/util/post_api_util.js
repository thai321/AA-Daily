
export const fetchPosts = () => (
  $.ajax({
    method: 'GET',
    url: 'api/posts',
  })
);

export const fetchPost = id => (
  $.ajax({
    method: 'GET',
    url: `api/posts/${id}`
  })
);

export const createPost = post => (
  $.ajax({
    url: 'api/posts',
    method: 'POST',
    data: { post }
  })
);

export const updatePost = post => (
  $.ajax({
    url: `api/posts/${post.id}`,
    method: 'PATCH',
    data: { post }
  })
);

export const deletePost = id => (
  $.ajax({
    url: `api/posts/${id}`,
    method: 'DELETE'
  })
);
