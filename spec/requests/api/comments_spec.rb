require 'rails_helper'

describe API::API, api: true  do
  include ApiSpecHelpers

  let(:user) { FactoryGirl.create(:user) }
  let(:idea) { FactoryGirl.create(:idea, author: user) }
  let(:comment) { FactoryGirl.create(:idea_comment, user: user, commentable: idea) }

  describe "GET /ideas/:id/comments" do
    before { comment }

    context "when unauthenticated" do
      it "should return authentication error" do
        get api("/ideas/#{idea.id}/comments")
        expect(response.status).to eq 401
      end
    end

    context "when authenticated" do
      it "should return an array of comments" do
        get api("/ideas/#{idea.id}/comments", user)
        expect(response.status).to eq 200
        expect(json_response).to be_an Array
        expect(json_response.first['body']).to eq idea.title
        expect(json_response.first['commentator']['username']).to eq user.username
      end
    end
  end

  describe "POST /ideas/:id/comments" do
    before { @comment_attributes = FactoryGirl.attributes_for(:comment, :body => 'test') }

    context "when unauthenticated" do
      it "should return authentication error" do
        post api("/ideas/#{idea.id}/comments")
        expect(response.status).to eq 401
      end
    end

    context "invalid parameters" do
      it "should return a 400 error if body not given" do
        post api("/ideas/#{idea.id}/comments", user)
        expect(response.status).to eq 400
      end
    end

    context "valid parameters" do
      it "should respond with 201 on success" do
        post api("/ideas/#{idea.id}/comments", user), @comment_attributes
        expect(response.status).to eq 201
        expect(json_response['body']).to eq @comment_attributes[:body]
        expect(json_response['commentator']['username']).to eq user.username
      end
    end
  end

  describe "DELETE /comments/:id" do
    before { comment }

    context "unauthenticated" do
      it "should return authentication error" do
        delete api("/comments/#{comment.id}")
        expect(response.status).to eq 401
      end

      it "should return authentication error when not the author" do
        delete api("/comments/#{comment.id}", FactoryGirl.create(:user))
        expect(response.status).to eq 401
      end
    end

    context "authenticated" do
      it "should respond with 200 on success" do
        delete api("/comments/#{comment.id}", user)
        expect(response.status).to eq 200
      end
    end
  end
end
