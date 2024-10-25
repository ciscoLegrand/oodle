
module Oodle
  class DashboardController < ApplicationController
    def index
      if Current.user.manager?
        @questionnaires = Questionnaire.where(manager_id: Current.user.id).sorted
        @students = Current.user.students
        @questions = Question.all
        @user_questionnaires = Current.user.students.flat_map(&:user_questionnaires)
      else
        @user_questionnaires = Current.user.user_questionnaires
        @completed_questionnaires = @user_questionnaires
        @incompleted_questionnaires = @user_questionnaires.incompleted
      end
    end
    private
  end
end
