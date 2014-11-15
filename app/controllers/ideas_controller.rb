class IdeasController < ApplicationController
  before_action :get_idea, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = current_user.ideas.build(idea_params)

    if @idea.save
      flash[:success] = "Idea created!"
      redirect_to @idea
    else
      render :new
    end
  end

  protected

    def get_idea
      @idea = Idea.find(params[:id])
    end

    def idea_params
      params.require(:idea).permit(:title, :description)
    end
end