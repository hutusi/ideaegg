require 'rails_helper'

describe CommentsController do
  before do
     @user = FactoryGirl.create(:user)
     @idea = FactoryGirl.create(:idea)
   end

  describe 'POST #create' do
    before do
      @comment_attributes = FactoryGirl.attributes_for(:comment,
      :commentable_id => @idea.id, :commentable_type => 'Idea')
    end
    it 'redirect to sign in if not signed in' do
      # get :create, idea_id: @idea, comment: @comment_attributes
      # expect(response).to redirect_to sign_in_url
    end

    context 'sign in' do
      before do
        login_user @user
      end

      it 'save the new comment in database' do
        # expect {
        #   post :create, idea_id: @idea, id: @idea.id, comment: @comment_attributes
        # }.to change(Comment, :count).by(1)
      end
    end
  end
end
