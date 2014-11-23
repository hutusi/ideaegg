class IdeasController < ApplicationController
  before_action :get_idea, only: [:show, :edit, :update, :destroy, :like, :unlike]

  def index
    @ideas = Idea.order('created_at DESC').page params[:page]
  end

  def show
    @author = @idea.author
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

  def like
    respond_to do |format|
      liker = User.find(params[:liker_id])
      liker.like!(@idea)
      format.html { redirect_to @idea, notice: 'Like successfully.' }
      format.json { head :no_content }
    end
  end

  def unlike
    respond_to do |format|
      liker = User.find(params[:liker_id])
      liker.unlike!(@idea)
      format.html { redirect_to @idea, notice: 'Unlike successfully.' }
      format.json { head :no_content }
    end
  end

  protected

    def get_idea
      @idea = Idea.find(params[:id])
    end

    def idea_params
      params.require(:idea).permit(:title, :content)
    end
end
