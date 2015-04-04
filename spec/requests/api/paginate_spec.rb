require 'rails_helper'

describe API::API, api: true  do
  include ApiSpecHelpers

  let(:user) { FactoryGirl.create(:user) }

  describe "GET /ideas" do
    before do
      user
      @ideas = 25.times { FactoryGirl.create(:idea) }
    end

    it "should return first page by default" do
      get api("/ideas", user)
      expect(response.status).to eq 200
      expect(response.header['X-Total']).to eq '25'
      expect(response.header['X-Total-Pages']).to eq '3'
      expect(response.header['X-Page']).to eq '1'
      expect(response.header['X-Per-Page']).to eq '10'
      expect(response.header['X-Next-Page']).to eq '2'
      expect(response.header['X-Prev-Page']).to eq ''
    end

    it "should return specific page" do
      get api_with_page("/ideas", 2, 8, user)
      expect(response.status).to eq 200
      expect(response.header['X-Total']).to eq '25'
      expect(response.header['X-Total-Pages']).to eq '4'
      expect(response.header['X-Page']).to eq '2'
      expect(response.header['X-Per-Page']).to eq '8'
      expect(response.header['X-Next-Page']).to eq '3'
      expect(response.header['X-Prev-Page']).to eq '1'
    end

    it "should return first page if page no lower than 1" do
      get api_with_page("/ideas", -1, 8, user)
      expect(response.status).to eq 200
      expect(response.header['X-Total']).to eq '25'
      expect(response.header['X-Total-Pages']).to eq '4'
      expect(response.header['X-Page']).to eq '1'
      expect(response.header['X-Per-Page']).to eq '8'
      expect(response.header['X-Next-Page']).to eq '2'
      expect(response.header['X-Prev-Page']).to eq ''
    end

    it "should return last page if page no higher than maximum" do
      get api_with_page("/ideas", 5, 8, user)
      expect(response.status).to eq 200
      expect(response.header['X-Total']).to eq '25'
      expect(response.header['X-Total-Pages']).to eq '4'
      expect(response.header['X-Page']).to eq '5'
      expect(response.header['X-Per-Page']).to eq '8'
      expect(response.header['X-Next-Page']).to eq ''
      expect(response.header['X-Prev-Page']).to eq '4'
    end
  end
end
