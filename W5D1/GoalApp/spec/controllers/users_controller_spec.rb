require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    subject(:thai) { FactoryGirl.build(:thai) }


  describe "GET #index" do
    it "returns the index page and http success" do
      get :index
      expect(response).to render_template('index')
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns the new page http success" do
      get :new
      expect(response).to render_template('new')
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validate username's uniqueness" do
        thai.save
        post :create, params: { user: {
            username: 'thai',
            password: 'password'
          }
        }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end

      it "validate the username's present" do
        post :create, params: { user: {
          username: '',
          password: 'password'
          }
        }

        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end

      it "validates the password's present" do
        post :create, params: { user: {
          username: 'thai',
          password: ''
          }
        }

        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end


      it "validates the password's length is at least 6 characters" do
        post :create, params: { user: {
          username: 'thai',
          password: '12345'
          }
        }

        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "redirect to user show page with success" do
        post :create, params: { user: {
            username: 'thai1',
            password: 'password'
          }
        }
        expect(response).to redirect_to(users_url)
      end
    end
  end


  describe "GET #show" do
    it "returns http success" do
      thai.save
      get :show, params: { id: thai.id }
      expect(response).to render_template('show')
      expect(response).to have_http_status(:success)
    end
  end

end
