require 'rails_helper'

describe IdeasController do
  before { @user = FactoryGirl.create(:user) }

  describe 'GET #new' do
    it 'redirect to sign in if not signed in' do
      get :new
      expect(response).to redirect_to sign_in_url
    end

    context 'sign in' do
      before { login_user @user }

      it 'assigns a new user to @idea' do
        get :new
        expect(assigns(:idea)).to be_a_new(Idea)
      end

      it 'render the :show template' do
        get :new
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST #create' do
    before do
      login_user @user
      @idea_attributes = FactoryGirl.attributes_for(:idea)
    end

    it 'save the new idea in database' do
      expect {
        post :create, idea: @idea_attributes
      }.to change(Idea, :count).by(1)
    end
  end
end
