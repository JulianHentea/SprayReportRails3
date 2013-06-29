class CommentsController < ApplicationController
  def create
    @comment = Comment.new(user_params)
    @comment.post_id = params[:post]
    @comment.save
    redirect_to post_path(@comment.post)
  end

end