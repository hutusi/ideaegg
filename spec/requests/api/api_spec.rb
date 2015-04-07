require 'rails_helper'

describe API::API do
  include ApiSpecHelpers

  describe "POST /sign_up" do
    it 'returns user info' do
      params = FactoryGirl.attributes_for(:user)
      post api('/sign_up'), params
      expect(response.status).to eq 201
      expect(json_response['private_token']).to_not be_nil
    end

    it 'returns 400 error' do
      params = FactoryGirl.attributes_for(:user, :email => 'wrongfomat#')
      post api('/sign_up'), params
      expect(response.status).to eq 400
    end
  end

  describe "POST /sign_in" do
    before { @user = FactoryGirl.create(:user, :password => '12345678') }

    it 'returns user info when signed by username' do
      post api('/sign_in'), {:login => @user.username, :password => '12345678'}
      expect(response.status).to eq 201
      expect(json_response['private_token']).to_not be_nil
    end

    it 'returns user info when signed by email' do
      post api('/sign_in'), {:login => @user.email, :password => '12345678'}
      expect(response.status).to eq 201
      expect(json_response['private_token']).to_not be_nil
    end

    it 'returns 401 error by wrong password' do
      post api('/sign_in'), {:login => @user.username, :password => ''}
      expect(response.status).to eq 401
    end
  end

  describe "POST /sign_up_by_wechat" do
    it 'returns user info' do
      params = FactoryGirl.attributes_for(:user)
      post api('/sign_up_by_wechat'), params
      expect(response.status).to eq 201
      expect(json_response['private_token']).to_not be_nil
      expect(json_response['sign_up_type']).to eq "wechat"
    end
    
    it 'returns user info when only pass openid' do
      post api('/sign_up_by_wechat'), {:wechat_openid => 'helloworld'}
      expect(response.status).to eq 201
      expect(json_response['private_token']).to_not be_nil
      expect(json_response['sign_up_type']).to eq "wechat"
    end

    it 'returns 400 error' do
      params = FactoryGirl.attributes_for(:user, :email => 'wrongfomat#')
      post api('/sign_up_by_wechat'), params
      expect(response.status).to eq 400
    end
  end

  describe "POST /sign_in_by_wechat" do
    before { @user = FactoryGirl.create(:user, :wechat_openid => '12345678') }

    it 'returns user info when signed by wechat_id' do
      post api('/sign_in_by_wechat'), {:openid => '12345678'}
      expect(response.status).to eq 201
      expect(json_response['private_token']).to_not be_nil
    end

    it 'returns 401 error by wrong wechat_id' do
      post api('/sign_in_by_wechat'), {:openid => ''}
      expect(response.status).to eq 401
    end
  end

  describe "GET /app_setting" do
    context "when unauthenticated" do
      it "should return authentication error" do
        get api("/app_setting")
        expect(response.status).to eq 401
      end
    end

    context "when authenticated" do
      it "should return an array of ideas" do
        get api_with_ios_key("/app_setting")
        expect(response.status).to eq 200
        expect(json_response['qiniu']['access_key']).to eq Settings['qiniu']['access_key']
        expect(json_response['qiniu']['secret_key']).to eq Settings['qiniu']['secret_key']
        expect(json_response['qiniu']['bucket']).to eq Settings['qiniu']['bucket']
      end
    end
  end
end
