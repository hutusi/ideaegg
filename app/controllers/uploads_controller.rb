class UploadsController < ApplicationController
  before_action :signed_in_user

  def uptoken
    put_policy = Qiniu::Auth::PutPolicy.new('ideaegg-dev')
    uptoken = Qiniu::Auth.generate_uptoken(put_policy)
    render json: { uptoken: uptoken }
  end
end
