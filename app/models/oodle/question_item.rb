module Oodle
  class QuestionItem < ApplicationRecord
    belongs_to :question, class_name: "Oodle::Questionnaire"
    belongs_to :item, class_name: "Oodle::Item"
  end
end
