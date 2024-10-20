module Oodle
  class UserQuestionnaire < ApplicationRecord
    belongs_to :user, class_name: "::User"
    belongs_to :questionnaire, class_name: "Oodle::Questionnaire"

    has_many :answers, through: :questionnaire
  end
end
