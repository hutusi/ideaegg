require 'rails_helper'

require 'rspec/expectations'

RSpec::Matchers.define :successfully_followed do |followee|
  match do |follower|
    follower.reload
    followee.reload
    expect(followee.all_followers.count).to eq 1
    expect(follower.all_followees.count).to eq 1
  end

  failure_message do |follower|
    "expected to #{follower.username} follow #{followee.username}"
  end

  failure_message_when_negated do |follower|
    "expected not to #{follower.username} follow #{followee.username}"
  end
end


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
    it 'assigns the requested user to @user' do
      get :edit, id: @user
      expect(assigns(:user)).to eq @user
    end

    it 'render the :edit template' do
      get :edit, id: @user
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
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

  describe 'POST #follow' do
    before do
      @tom = FactoryGirl.create(:user)
      @jerry = FactoryGirl.create(:user)
    end

    it "follows successfully" do
      follow_user(@jerry, @tom)
      expect(@jerry).to successfully_followed(@tom)
    end
  end
end
