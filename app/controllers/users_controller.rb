class UsersController < ApplicationController
  before_action :get_user, only: [:show, :edit, :update]

  def show
    @ideas = @user.ideas.order('created_at DESC').page params[:page]
    if params[:show]
      @show = params[:show]
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  protected

    def get_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :fullname, :email)
    end
end
