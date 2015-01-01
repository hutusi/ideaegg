class IdeasController < ApplicationController
  include IdeasHelper

  before_action :get_idea, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :signed_in_user, only: [:new, :create, :edit, :update, :destroy, :like, :unlike]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @ideas = Idea.order('created_at DESC').page params[:page]
  end

  def show
    @idea.increment!(:visits_count)
    @author = @idea.author

    @comments = @idea.comment_threads
    @comment = Comment.new
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

  def edit
  end

  def update
    if @idea.update(idea_params)
      flash[:success] = "Idea was successfully updated."
      redirect_to @idea
    else
      render 'edit'
    end
  end

  def destroy
    @idea.destroy
    redirect_to root_path
  end

  def like
    respond_to do |format|
      liker = User.find(params[:liker_id])
      like_idea(liker, @idea)
      format.html { redirect_to @idea, notice: 'Like successfully.' }
      format.json { head :no_content }
    end
  end

  def unlike
    respond_to do |format|
      liker = User.find(params[:liker_id])
      unlike_idea(liker, @idea)
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

    def correct_user
      unless current_user == @idea.author
        redirect_to idea_path(@idea), notice: 'Not correct user.'
      end
    end
end
