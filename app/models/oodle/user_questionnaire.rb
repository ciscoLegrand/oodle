module Oodle
  class UserQuestionnaire < ApplicationRecord
    belongs_to :user, class_name: "::User"
    belongs_to :questionnaire, class_name: "Oodle::Questionnaire"
  end
end
