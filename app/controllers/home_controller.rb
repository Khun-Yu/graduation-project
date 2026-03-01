class HomeController < ApplicationController
  def index
    @recent_questions = Question.recent.includes(:ai_answer, :user).limit(5)
  end
end
