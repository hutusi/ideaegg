require 'rails_helper'

describe API::API, api: true do
  include API::APIHelpers

  let(:user) { FactoryGirl.create(:user) }
  let(:params) { {} }
  let(:env) { {} }

  def set_env(token_usr, identifier)
    clear_env
    clear_param
    env[API::APIHelpers::PRIVATE_TOKEN_HEADER] = token_usr.private_token
  end

  def set_param(token_usr, identifier)
    clear_env
    clear_param
    params[API::APIHelpers::PRIVATE_TOKEN_PARAM] = token_usr.private_token
  end

  def clear_env
    env.delete(API::APIHelpers::PRIVATE_TOKEN_HEADER)
  end

  def clear_param
    params.delete(API::APIHelpers::PRIVATE_TOKEN_PARAM)
  end

  def error!(message, status)
    raise Exception
  end

  describe ".current_user" do
    it "should return nil for an invalid token" do
      env[API::APIHelpers::PRIVATE_TOKEN_HEADER] = 'invalid token'
      expect(current_user).to be_nil
    end

    it "should leave user" do
      env[API::APIHelpers::PRIVATE_TOKEN_HEADER] = user.private_token
      expect(current_user).to eq user
      clear_env
      params[API::APIHelpers::PRIVATE_TOKEN_PARAM] = user.private_token
      expect(current_user).to eq user
    end
  end
end
