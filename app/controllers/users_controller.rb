class UsersController < ApplicationController
  before_action :get_user, only: [:show, :edit, :update]

  def show
  end
  
  protected

    def get_user
      @idea = User.find(params[:id])
    end
end
