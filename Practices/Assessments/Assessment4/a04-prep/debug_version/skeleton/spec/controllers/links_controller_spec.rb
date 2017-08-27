require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  let(:jack) { User.create!(username: 'jack_bruce', password: 'abcdef') }

  before(:each) do
    allow_message_expectations_on_nil
  end

  describe 'GET #new' do
    context 'when logged in' do
      before do
        allow(controller).to receive(:current_user) { jack }
      end

      it 'renders the new links page' do
        get :new
        expect(response).to render_template('new')
      end
    end

    context 'when logged out' do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it 'redirects to the login page' do
        get :new
        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe 'POST #create' do
    let(:jack_bruce) { User.create!(username: 'jack_bruce', password: 'abcdef') }

    context 'when logged out' do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it 'redirects to the login page' do
        post :create, params: { link: {} }
        expect(response).to redirect_to(new_session_url)
      end
    end

    context 'when logged in' do
      before do
        allow(controller).to receive(:current_user) { jack_bruce }
      end

      context 'with invalid params' do
        it 'validates the presence of title and url' do
          post :create, params: { link: { title: 'this is an invalid link' } }
          expect(response).to render_template('new')
          expect(flash[:errors]).to be_present
        end
      end

      context 'with valid params' do
        it 'redirects to the link show page' do
          post :create, params: { link: { title: 'teehee', url: 'cats.com' } }
          expect(response).to redirect_to(link_url(Link.last))
        end
      end
    end
  end

  describe 'GET #index' do
    context 'when logged in' do
      before do
        allow(controller).to receive(:current_user) { jack }
      end

      it 'renders the new links page' do
        get :index
        expect(response).to render_template('index')
      end
    end

    context 'when logged out' do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it 'redirects to the login page' do
        get :index
        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe 'GET #show' do
    create_jill_with_link

    context 'when logged in' do
      before do
        allow(controller).to receive(:current_user) { jack }
      end

      it 'renders the link show page' do
        get :show, params: { id: jill_link.id }
        expect(response).to render_template('show')
      end
    end

    context 'when logged out' do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it 'redirects to the login page' do
        get :show, params: { id: jill_link.id }
        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe 'GET #edit' do
    context 'when logged in' do
      before do
        allow(controller).to receive(:current_user) { jack }
        @link = Link.create(
          title: 'check out neopets',
          url: 'neopets.com',
          user: jack
        )
      end

      it 'renders the edit link page' do
        get :edit, params: { id: @link.id }
        expect(response).to render_template('edit')
      end
    end

    context 'when logged out' do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it 'redirects to the login page' do
        get :new, params: { link: {} }
        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe 'PATCH #update' do
    create_jill_with_link

    context 'when logged in as a different user' do
      before do
        allow(controller).to receive(:current_user) { jack }
      end

      it 'should not allow users to update another users links' do
        begin
          patch :update, params: { id: jill_link.id, link: { title: 'Jack Hax' } }
        rescue ActiveRecord::RecordNotFound
        end

        updated_link = Link.find(jill_link.id)
        expect(updated_link.title).to eq('Jill Link')
      end
    end

    context 'when logged in as the correct user' do
      before do
        allow(controller).to receive(:current_user) { jill }
      end

      it 'should not allow users to update another users links' do
        patch :update, params: { id: jill_link.id, link: { title: 'I is jill' } }

        updated_link = Link.find(jill_link.id)
        expect(updated_link.title).to eq('I is jill')
      end
    end
  end
end
