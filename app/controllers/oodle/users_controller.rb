module Oodle
  class UsersController < ApplicationController
    # GET /users
    def index
      @users = Current.user.students.all
      @pagy, @users = pagy(@users)
    end

    # GET /users/:id
    def show
      @user = User.find(params[:id])
      @user_questionnaires = @user.user_questionnaires.includes(questionnaire: :questions)

      @questionnaires_progress_and_scores = @user_questionnaires.map do |user_questionnaire|
        {
          questionnaire: user_questionnaire.questionnaire,
          progress: user_questionnaire.progress,
          total_score: user_questionnaire.score
        }
      end
    end
  end
end
