class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @questions = Question.recent.includes(:ai_answer, :user)
    @questions = @questions.search_by_keyword(params[:keyword]) if params[:keyword].present?
    @questions = @questions.page(params[:page]).per(10)
  end

  def show
    @question = Question.includes(:ai_answer, :user).find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)

    if @question.save
      AiAnswerService.new(@question).call
      redirect_to @question, notice: "質問を投稿しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end
end
