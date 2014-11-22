class UsersController < ApplicationController
  before_action :get_user, only: [:show, :edit, :update]

  def show
    @ideas = @user.ideas.order('created_at DESC').page params[:page]
    if params[:show]
      @show = params[:show]
    end
  end

  protected

    def get_user
      @user = User.find(params[:id])
    end
end
