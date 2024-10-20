module Oodle
  class QuestionnaireQuestion < ApplicationRecord
    belongs_to :questionnaire, class_name: "Oodle::Questionnaire"
    belongs_to :question, class_name: "Oodle::Question"
  end
end
