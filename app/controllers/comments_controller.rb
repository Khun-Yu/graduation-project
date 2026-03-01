class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find(params[:question_id])
    @comment = @question.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @question, notice: "コメントを投稿しました。"
    else
      redirect_to @question, alert: "コメントの投稿に失敗しました。"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
