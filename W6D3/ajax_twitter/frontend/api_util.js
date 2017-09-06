const APIUtil = {
  followUser: (id) => {
    return $.ajax({
      url: `http://localhost:3000/users/${id}/follow`,
      method: 'POST',
      dataType: 'JSON'
    });
  },

  unfollowUser: (id) => {
    return $.ajax({
      url: `http://localhost:3000/users/${id}/follow`,
      method: 'DELETE',
      dataType: 'JSON'
    });
  }
};

module.exports = APIUtil;
