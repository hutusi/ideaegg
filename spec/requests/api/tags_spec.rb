require 'rails_helper'

describe API::API, api: true  do
  include ApiSpecHelpers

  let(:user) { FactoryGirl.create(:user) }

  describe "GET /tags" do
    before { user }
    
    context "Normal condition" do
      it "should return an array of tags" do
        tag1 = FactoryGirl.create(:tag, taggings_count: 1)
        tag2 = FactoryGirl.create(:tag, taggings_count: 5)
        tag3 = FactoryGirl.create(:tag, taggings_count: 3)
        
        get api("/tags", user)
        expect(response.status).to eq 200
        expect(json_response).to be_an Array
        expect(json_response.first['name']).to eq tag2.name
        expect(json_response.first['taggings_count']).to eq tag2.taggings_count
      end
    end
  end
end