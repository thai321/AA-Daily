require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let!(:user) { User.create({ username: 'jack_bruce', password: 'abcdef' }) }

  describe 'GET #new' do
    it 'renders the new session template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    context 'with invalid credentials' do
      it 'returns to sign in with an non-existent user' do
        post :create, params: { user: { username: 'jill_bruce', password: 'abcdef' } }
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end

      it 'returns to sign in on bad password' do
        post :create, params: { user: { username: 'jack_bruce', password: 'notmypassword' } }
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end
    end

    context 'with valid credentials' do
      it 'redirects user to links index on success' do
        post :create, params: { user: { username: 'jack_bruce', password: 'abcdef' } }
        expect(response).to redirect_to(links_url)
      end

      it 'logs in the user' do
        post :create, params: { user: { username: 'jack_bruce', password: 'abcdef' } }
        user = User.find_by_username('jack_bruce')

        expect(session[:session_token]).to eq(user.session_token)
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      post :create, params: { user: { username: 'jack_bruce', password: 'abcdef' } }
      @session_token = User.find_by_username('jack_bruce').session_token
    end

    it 'logs out the current user' do
      delete :destroy
      expect(session[:session_token]).to be_nil

      jack = User.find_by_username('jack_bruce')
      expect(jack.session_token).not_to eq(@session_token)
    end
  end
end
