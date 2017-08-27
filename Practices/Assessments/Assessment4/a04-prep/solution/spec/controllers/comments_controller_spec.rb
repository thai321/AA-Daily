require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:jack_bruce) { User.create!(username: 'jack_bruce', password: 'abcdef') }

  let(:link) do
    Link.create!(user: jack_bruce, title: 'neopets', url: 'neopets.com')
  end

  let(:comment) do
    Comment.create!(body: 'omg neopets', user_id: jack_bruce.id, link_id: link.id)
  end

  before(:each) do
    allow_message_expectations_on_nil
  end

  describe 'POST #create' do
    # NOTE: for post requests, the link_id should be sent in the url, like so:
    # '/links/:link_id/comments'
    it { should route(:post, '/links/1/comments').to(action: :create, link_id: 1) }

    context 'when logged out' do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it 'redirects to the login page' do
        post :create, params: { link_id: link.id, comment: { body: 'cool' } }
        expect(response).to redirect_to(new_session_url)
      end
    end

    context 'when logged in' do
      before do
        allow(controller).to receive(:current_user) { jack_bruce }
      end

      context 'with invalid params' do
        it 'flashes errors' do
          post :create, params: { link_id: link.id, comment: { body: nil } }
          expect(flash[:errors]).to be_present
        end
      end

      context 'with valid params' do
        it 'redirects to the link show page' do
          post :create, params: { link_id: link.id, comment: { body: 'a comment' } }
          expect(response).to redirect_to(link_url(link))
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when logged out' do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it 'redirects to the login page' do
        delete :destroy, params: { id: comment.id }
        expect(response).to redirect_to(new_session_url)
      end
    end

    context 'when logged in' do
      before do
        allow(controller).to receive(:current_user) { jack_bruce }
      end

      it 'removes the comment and redirects back to the link' do
        delete :destroy, params: { id: comment.id }
        expect(response).to redirect_to(link_url(link))
        expect(Comment.exists?(comment.id)).to be false
      end
    end
  end
end
