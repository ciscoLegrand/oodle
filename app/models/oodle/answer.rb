module Oodle
  class Answer < ApplicationRecord
    belongs_to :user, class_name: "::User"
    belongs_to :question, class_name: "Oodle::Question"
    belongs_to :questionnaire, class_name: "Oodle::Questionnaire"

    validates :result, presence: true
  end
end
