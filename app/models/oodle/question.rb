module Oodle
  class Question < ApplicationRecord
    enum question_type: { free_text: 0, simple: 1, multiple: 2 }

    validates :name, :question_type, presence: true
  end
end
