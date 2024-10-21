module Oodle
  class Answer < ApplicationRecord
    belongs_to :user, class_name: "::User"
    belongs_to :question, class_name: "Oodle::Question"
    belongs_to :questionnaire, class_name: "Oodle::Questionnaire"

    validates :result, presence: true

    after_create :update_questionnaire_progress

    def calculate_score(selected_answers, items)
      total_score = 0.0

      items.each do |item|
        if selected_answers.include?(item.display_value)
          total_score += item.correct_value ? item.score : -item.score
        else
          total_score += item.correct_value ? -item.score : 0
        end
      end

      update! score: total_score
    end

    private

    def update_questionnaire_progress
      user.user_questionnaires
          .find_by(user: user, questionnaire: questionnaire)
          .update_progress
    end
  end
end
