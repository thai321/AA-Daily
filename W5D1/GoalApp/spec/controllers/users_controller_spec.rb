require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    subject


  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to render_template('index')
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to render_template('new')
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    xit "returns http success" do
      get :create

      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    xit "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to render_template('show')
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    xit "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end


end
