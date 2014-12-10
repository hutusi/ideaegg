require 'rails_helper'

describe UsersController do
  before { @user = FactoryGirl.create(:user) }

  describe 'GET #show' do
    it 'assigns the requested user to @user' do
      get :show, id: @user
      expect(assigns(:user)).to eq @user
    end

    it 'render the :show template' do
      get :show, id: @user
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit' do
    it 'redirect to sign in if not signed in' do
      get :edit, id: @user
      expect(response).to redirect_to sign_in_url
    end

    context 'other user sign in' do
      it 'redirect to corrent user page if not signed user' do
        me = FactoryGirl.create(:user)
        login_user me
        get :edit, id: @user
        expect(response).to redirect_to edit_user_path(me)
      end
    end

    context 'sign in' do
      before { login_user @user }

      it 'assigns the requested user to @user' do
        get :edit, id: @user
        expect(assigns(:user)).to eq @user
      end

      it 'render the :edit template' do
        get :edit, id: @user
        expect(response).to render_template :edit
      end
    end
  end

  describe 'PATCH #update' do
    it 'redirect to sign in if not signed in' do
      get :edit, id: @user
      expect(response).to redirect_to sign_in_url
    end

    context 'other user sign in' do
      it 'redirect to corrent user page if not signed user' do
        me = FactoryGirl.create(:user)
        login_user me
        get :edit, id: @user
        expect(response).to redirect_to edit_user_path(me)
      end
    end

    context 'sign in' do
      before { login_user @user }

      context 'with valid attributes' do
        before { @valid_attributes = FactoryGirl.attributes_for(:user,
          fullname: 'Lisa', email: 'lisa@ideaegg.me')}
        it "changes @user's informations" do
          patch :update, id: @user,
            user: @valid_attributes
          @user.reload
          expect(@user.fullname).to eq 'Lisa'
          expect(@user.email).to eq 'lisa@ideaegg.me'
        end

        it "redirects to the updated user" do
          patch :update, id: @user,
          user: @valid_attributes
          expect(response).to redirect_to @user
        end
      end

      context 'with invalid attributes' do
        before { @invalid_attributes = FactoryGirl.attributes_for(:user,
          fullname: 'Lisa', email: 'lisa#ideaegg.me')}

        it "does not change @user's fullname" do
            old_info = @user.dup
            patch :update, id: @user,
            user: FactoryGirl.attributes_for(:user,
            fullname: '', email: 'lisa@ideaegg.me')
            @user.reload
            expect(@user.fullname).to eq old_info.fullname
          end

        it "does not change @user's email" do
          old_info = @user.dup
          patch :update, id: @user,
            user: @invalid_attributes
          @user.reload
          expect(@user.fullname).to eq old_info.fullname
          expect(@user.email).to eq old_info.email
        end

        it "re-renders the edit template" do
          patch :update, id: @user,
            user: @invalid_attributes
          expect(response).to render_template :edit
        end
      end
    end
  end

  describe 'POST #follow' do
    before do
      @tom = FactoryGirl.create(:user)
      @jerry = FactoryGirl.create(:user)
    end

    it 'redirect to sign in if not signed in' do
      follow_user(@jerry, @tom)
      expect(response).to redirect_to sign_in_url
    end

    context 'signed in' do
      before { login_user @jerry }

      it "follows successfully" do
        follow_user(@jerry, @tom)
        expect(@jerry).to successfully_followed(@tom)
      end

      it "should not follow yourself" do
        follow_user(@jerry, @jerry)
        expect(@jerry).not_to successfully_followed(@jerry)
      end
    end
  end

  describe 'POST #unfollow' do
    before do
      @tom = FactoryGirl.create(:user)
      @jerry = FactoryGirl.create(:user)
    end

    context 'signed in' do
      before { login_user @jerry }

      it "unfollows successfully" do
        follow_user(@jerry, @tom)
        expect(@jerry).to successfully_followed(@tom)

        unfollow_user(@jerry, @tom)
        expect(@jerry).to successfully_unfollowed(@tom)
      end
    end
  end
end
