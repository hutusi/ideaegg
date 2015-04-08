require 'rails_helper'

describe IdeasController do
  before { @user = FactoryGirl.create(:user) }
  
  describe 'GET #index' do
    it 'redirect to sign in if not signed in' do
      get :new
      expect(response).to redirect_to sign_in_url
    end
    
    context 'sign in' do
      before { login_user @user }
      
      it 'should return idea list' do
        get :index
        expect(response.status).to eq 200
      end
    end
  end

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

  describe 'GET #edit' do
    it 'redirect to sign in if not signed in' do
      @idea = FactoryGirl.create(:idea)
      get :edit, id: @idea
      expect(response).to redirect_to sign_in_url
    end

    context "edit other user's idea" do
      before do
        login_user @user
        @idea = FactoryGirl.create(:idea)
      end

      it 'should not redirect to edit path' do
        get :edit, id: @idea
        expect(response).not_to render_template :edit
      end
    end

    context 'edit self idea' do
      before do
         login_user @user
         @idea = FactoryGirl.create(:idea, author: @user)
       end

      it 'assigns the requested idea to @idea' do
        get :edit, id: @idea
        expect(assigns(:idea)).to eq @idea
      end

      it 'render the :edit template' do
        get :edit, id: @idea
        expect(response).to render_template :edit
      end
    end
  end

  describe 'PATCH #update' do
    it 'redirect to sign in if not signed in' do
      @idea = FactoryGirl.create(:idea)
      get :edit, id: @idea
      expect(response).to redirect_to sign_in_url
    end

    context 'sign in' do
      before do
        login_user @user
        @idea = FactoryGirl.create(:idea, author: @user)
      end

      context 'with valid attributes' do
        before { @valid_attributes = FactoryGirl.attributes_for(:idea,
          title: 'Hello', content: 'World')}
        it "changes @idea's informations" do
          patch :update, id: @idea,
          idea: @valid_attributes
          @idea.reload
          expect(@idea.title).to eq 'Hello'
          expect(@idea.content).to eq 'World'
        end

        it "redirects to the updated idea" do
          patch :update, id: @idea,
          idea: @valid_attributes
          expect(response).to redirect_to @idea
        end
      end

      context 'with invalid attributes' do
        before { @invalid_attributes = FactoryGirl.attributes_for(:idea,
          title: '', conten: '')}

        it "does not change @idea's title" do
          old_info = @idea.dup
          patch :update, id: @idea,
          idea: @invalid_attributes
          @idea.reload
          expect(@idea.title).to eq old_info.title
        end

        it "re-renders the edit template" do
          patch :update, id: @idea,
          idea: @invalid_attributes
          expect(response).to render_template :edit
        end
      end
    end
  end

  describe 'POST #like' do
    before do
      login_user @user
      @idea = FactoryGirl.create(:idea)
    end

    it 'like the idea' do
      post :like, id: @idea, liker_id: @user
      expect(@user).to successfully_liked(@idea)
    end

    it 'should not like idea again' do
      post :like, id: @idea, liker_id: @user
      expect(@user).to successfully_liked(@idea)
      count = @idea.votes_for.up.size
      liked_count = @user.liked_ideas_count
      post :like, id: @idea, liker_id: @user
      @idea.reload
      @user.reload
      expect(count).to eq @idea.votes_for.up.size
      expect(@user.liked_ideas_count ).to eq liked_count
    end

    it 'unlike the idea' do
      post :like, id: @idea, liker_id: @user
      expect(@user).to successfully_liked(@idea)

      post :unlike, id: @idea, liker_id: @user
      expect(@user).to successfully_unliked(@idea)
    end

    it 'should not unlike unliked idea' do
      count = @idea.votes_for.up.size
      liked_count = @user.liked_ideas_count
      post :unlike, id: @idea, liker_id: @user
      @idea.reload
      @user.reload
      expect(count).to eq @idea.votes_for.up.size
      expect(@user.liked_ideas_count ).to eq liked_count
    end
  end
end
