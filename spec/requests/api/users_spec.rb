require 'rails_helper'

describe API::API, api: true  do
  include ApiSpecHelpers

  let(:user) { FactoryGirl.create(:user) }
  let(:follower) { FactoryGirl.create(:user) }

  describe "GET /users" do
    before { user }

    context "when unauthenticated" do
      it "should return authentication error" do
        get api("/users")
        expect(response.status).to eq 401
      end
    end

    context "when authenticated" do
      it "should return an array of users" do
        get api("/users", user)
        expect(response.status).to eq 200
        expect(json_response).to be_an Array
        expect(json_response.first['username']).to eq user.username
      end
    end
  end

  describe "GET /users/:id" do
    before { user }

    context "when unauthenticated" do
      it "should return authentication error" do
        get api("/users/#{user.id}")
        expect(response.status).to eq 401
      end
    end

    context "when authenticated" do
      it "should return specific user" do
        get api("/users/#{user.id}", user)
        expect(response.status).to eq 200
        expect(json_response['username']).to eq user.username
      end
    end
  end

  describe "PUT /users/:id" do
    before { user }

    context ".unauthenticated" do
      it "should return authentication error" do
        put api("/users/#{user.id}")
        expect(response.status).to eq 401
      end

      it "should return authentication error when not the user" do
        put api("/users/#{user.id}", FactoryGirl.create(:user))
        expect(response.status).to eq 401
      end
    end

    context "valid parameters" do
      before { @user_attributes = FactoryGirl.attributes_for(:user, :username => 'test') }

      it "should respond with 200 on success" do
        put api("/users/#{user.id}", user), @user_attributes
        expect(response.status).to eq 200
        expect(json_response['username']).to eq @user_attributes[:username]
      end
    end
  end

  describe "POST /users/:id/follow" do
    before do
      user
      follower
    end

    context "unauthenticated" do
      it "should return authentication error" do
        post api("/users/#{user.id}/follow")
        expect(response.status).to eq 401
      end
    end

    context "authenticated" do
      it "should respond with 201 on success" do
        post api("/users/#{user.id}/follow", follower)
        expect(response.status).to eq 201
        expect(follower).to successfully_followed(user)
      end
    end
  end

  describe "DELETE /users/:id/follow" do
    before do
      user
      follower
    end

    context "unauthenticated" do
      it "should return authentication error" do
        delete api("/users/#{user.id}/follow")
        expect(response.status).to eq 401
      end
    end

    context "authenticated" do
      it "should respond with 201 on success" do
        post api("/users/#{user.id}/follow", follower)
        expect(response.status).to eq 201
        expect(follower).to successfully_followed(user)

        delete api("/users/#{user.id}/follow", follower)
        expect(response.status).to eq 200
        expect(follower).to successfully_unfollowed(user)
      end
    end
  end
end
