module Oodle
  class Question < ApplicationRecord
    has_many :questionnaire_questions, dependent: :destroy
    has_many :questionnaires, through: :questionnaire_questions
    has_many :answers

    enum question_type: { free_text: 0, simple: 1, multiple: 2 }

    validates :name, :question_type, presence: true
  end
end
