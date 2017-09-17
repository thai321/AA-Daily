/* globals jest */

import * as PostApiUtil from '../util/post_api_util';

import {
  RECEIVE_ALL_POSTS,
  RECEIVE_POST,
  REMOVE_POST,
  fetchPosts,
  fetchPost,
  createPost,
  updatePost,
  deletePost
} from '../actions/post_actions';

import thunk from 'redux-thunk';
import configureMockStore from 'redux-mock-store';

const middlewares = [ thunk ];
const mockStore = configureMockStore(middlewares);

describe('post actions', () => {
  describe('post constants', () => {
    it('should contain a RECEIVE_ALL_POSTS constant', () => {
      expect(RECEIVE_ALL_POSTS).toEqual('RECEIVE_ALL_POSTS');
    });

    it('should contain a RECEIVE_POST constant', () => {
      expect(RECEIVE_POST).toEqual('RECEIVE_POST');
    });

    it('should contain a REMOVE_POST constant', () => {
      expect(REMOVE_POST).toEqual('REMOVE_POST');
    });
  });

  describe('thunks', () => {
    let store;

    beforeEach(() => {
      store = mockStore({ posts: {} });
    });

    describe('fetchPosts', () => {
      it('should export a fetchPosts function', () => {
        expect(typeof fetchPosts).toEqual('function');
      });

      it('dispatches RECEIVE_ALL_POSTS when posts have been fetched', () => {
        const posts = { 1: { id: 1, title: "Test", body: "Works?"} };
        PostApiUtil.fetchPosts = jest.fn(() => (
          Promise.resolve(posts)
        ));
        const expectedActions = [{ type: "RECEIVE_ALL_POSTS", posts }];

        return store.dispatch(fetchPosts()).then(() => {
          expect(store.getActions()).toEqual(expectedActions);
        });
      });
    });

    describe('fetchPost', () => {
      it('should export a fetchPost function', () => {
        expect(typeof fetchPost).toEqual('function');
      });

      it('dispatches RECEIVE_POST when a single post has been fetched', () => {
        const posts = { 1: { id: 1, title: "Test", body: "Works?"} };
        PostApiUtil.fetchPost = jest.fn(id => (
          Promise.resolve({ [id]: posts[id] })
        ));
        const expectedActions = [{ type: "RECEIVE_POST", post: posts }];

        return store.dispatch(fetchPost(1)).then(() => {
          expect(store.getActions()).toEqual(expectedActions);
        });
      });
    });

    describe('createPost', () => {
      it('should export a createPost function', () => {
        expect(typeof createPost).toEqual('function');
      });

      it('dispatches RECEIVE_POST when a post has been created', () => {
        const newPost = { title: "New Title", body: "New Body" };
        PostApiUtil.createPost = jest.fn((post) => (
          Promise.resolve({ 1: post })
        ));
        const expectedActions = [{ type: "RECEIVE_POST", post: { 1: newPost }}];

        return store.dispatch(createPost(newPost)).then(() => {
          expect(store.getActions()).toEqual(expectedActions);
        });
      });
    });

    describe('updatePost', () => {
      it('should export an updatePost function', () => {
        expect(typeof updatePost).toEqual('function');
      });

      it('dispatches RECEIVE_POST when a post has been updated', () => {
        const updatedPost = { title: "Updated Title", body: "Updated Body", id: 2 };
        PostApiUtil.updatePost = jest.fn((post) => (
          Promise.resolve({ [updatedPost.id]: updatedPost })
        ));
        
        const expectedActions = [{
          type: "RECEIVE_POST",
          post: { [updatedPost.id]: updatedPost }
        }];

        return store.dispatch(updatePost(updatedPost)).then(() => {
          expect(store.getActions()).toEqual(expectedActions);
        });
      });
    });

    describe('deletePost', () => {
      it('should export a deletePost function', () => {
        expect(typeof updatePost).toEqual('function');
      });

      it('dispatches REMOVE_POST when a post has been deleted', () => {
        const post = { title: "Title", body: "Body", id: 3 };
        PostApiUtil.deletePost = jest.fn((post) => (
          Promise.resolve({ [post.id]: post })
        ));
        const expectedActions = [{
          type: "REMOVE_POST",
          post: { [post.id]: post }
        }];

        return store.dispatch(deletePost(post)).then(() => {
          expect(store.getActions()).toEqual(expectedActions);
        });
      });
    });
  });
});
