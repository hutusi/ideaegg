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
end
