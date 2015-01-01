require 'rails_helper'

describe API::API, api: true  do
  include ApiSpecHelpers

  let(:user) { FactoryGirl.create(:user) }
  let(:idea) { FactoryGirl.create(:idea, author: user) }

  describe "GET /ideas" do
    before { idea }

    context "when unauthenticated" do
      it "should return authentication error" do
        get api("/ideas")
        expect(response.status).to eq 401
      end
    end

    context "when authenticated" do
      it "should return an array of projects" do
        get api("/ideas", user)
        expect(response.status).to eq 200
        expect(json_response).to be_an Array
        expect(json_response.first['title']).to eq idea.title
        expect(json_response.first['author']['username']).to eq user.username
      end
    end
  end

  describe "POST /ideas" do
    before { @idea_attributes = FactoryGirl.attributes_for(:idea, :title => 'test') }

    context "when unauthenticated" do
      it "should return authentication error" do
        post api("/ideas")
        expect(response.status).to eq 401
      end
    end

    context "invalid parameters" do
      it "should return a 400 error if title not given" do
        post api("/ideas", user)
        expect(response.status).to eq 400
      end
    end

    context "valid parameters" do
      it "should respond with 201 on success" do
        post api("/ideas", user), @idea_attributes
        expect(response.status).to eq 201
        expect(json_response['title']).to eq @idea_attributes[:title]
      end
    end
  end

  describe "PUT /ideas/:id" do
    before { idea }

    context ".unauthenticated" do
      it "should return authentication error" do
        put api("/ideas/#{idea.id}")
        expect(response.status).to eq 401
      end

      it "should return authentication error when not the author" do
        put api("/ideas/#{idea.id}", FactoryGirl.create(:user))
        expect(response.status).to eq 401
      end
    end

    context "valid parameters" do
      before { @idea_attributes = FactoryGirl.attributes_for(:idea, :title => 'test') }

      it "should respond with 200 on success" do
        put api("/ideas/#{idea.id}", user), @idea_attributes
        expect(response.status).to eq 200
        expect(json_response['title']).to eq @idea_attributes[:title]
      end
    end
  end

  describe "DELETE /ideas/:id" do
    before { idea }

    context "unauthenticated" do
      it "should return authentication error" do
        delete api("/ideas/#{idea.id}")
        expect(response.status).to eq 401
      end

      it "should return authentication error when not the author" do
        delete api("/ideas/#{idea.id}", FactoryGirl.create(:user))
        expect(response.status).to eq 401
      end
    end

    context "authenticated" do
      it "should respond with 200 on success" do
        delete api("/ideas/#{idea.id}", user)
        expect(response.status).to eq 200
      end
    end
  end

  describe "POST /ideas/:id/like" do
    before { idea }

    context "unauthenticated" do
      it "should return authentication error" do
        post api("/ideas/#{idea.id}/like")
        expect(response.status).to eq 401
      end
    end

    context "authenticated" do
      let(:liker) { FactoryGirl.create(:user) }

      it "should respond with 201 on success" do
        post api("/ideas/#{idea.id}/like", liker)
        expect(response.status).to eq 201
        expect(liker.liked? idea).to be true
      end
    end
  end

  describe "DELETE /ideas/:id/like" do
    before { idea }

    context "unauthenticated" do
      it "should return authentication error" do
        delete api("/ideas/#{idea.id}/like")
        expect(response.status).to eq 401
      end
    end

    context "authenticated" do
      let(:liker) { FactoryGirl.create(:user) }

      it "should respond with 200 on success" do
        post api("/ideas/#{idea.id}/like", liker)
        expect(response.status).to eq 201
        expect(liker.liked? idea).to be true

        delete api("/ideas/#{idea.id}/like", liker)
        expect(response.status).to eq 200
        expect(liker.liked? idea).to be false
      end

    end
  end
end
