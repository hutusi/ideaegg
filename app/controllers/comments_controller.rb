class CommentsController < ApplicationController
  def create
    @commentable = Idea.find(comment_params[:idea_id])
    @user = current_user
    @comment = Comment.build_from( @commentable, @user.id, comment_params[:body] )

    if @comment.save
      flash[:success] = "Comment added!"
      redirect_to @commentable
    else
      flash[:error] = @comment.errors.full_messages.join("<br />")
      redirect_to @commentable
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body, :idea_id, :user_id)
    end
end
