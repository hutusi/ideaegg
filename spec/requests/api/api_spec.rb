require 'rails_helper'

describe API::API do
  describe "POST /api/v1/sign_up" do
    it 'returns user info' do
      params = FactoryGirl.attributes_for(:user)
      post '/api/v1/sign_up', params
      expect(response.status).to eq 201
      expect(response.body['private_token']).to_not be_nil
    end

    it 'returns 400 error' do
      params = FactoryGirl.attributes_for(:user, :email => 'wrongfomat#')
      post '/api/v1/sign_up', params
      expect(response.status).to eq 400
    end
  end

  describe "POST /api/v1/sign_in" do
    before { @user = FactoryGirl.create(:user, :password => '12345678') }

    it 'returns user info when signed by username' do
      post '/api/v1/sign_in', {:login => @user.username, :password => '12345678'}
      expect(response.status).to eq 201
      expect(response.body['private_token']).to_not be_nil
    end

    it 'returns user info when signed by email' do
      post '/api/v1/sign_in', {:login => @user.email, :password => '12345678'}
      expect(response.status).to eq 201
      expect(response.body['private_token']).to_not be_nil
    end

    it 'returns 401 error by wrong password' do
      post '/api/v1/sign_in', {:login => @user.username, :password => ''}
      expect(response.status).to eq 401
    end
  end
end
