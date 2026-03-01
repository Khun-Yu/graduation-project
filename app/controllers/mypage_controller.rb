class MypageController < ApplicationController
  before_action :authenticate_user!

  def show
    @questions = current_user.questions.recent.includes(:ai_answer).page(params[:page]).per(10)
  end
end
