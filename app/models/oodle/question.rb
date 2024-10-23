module Oodle
  class Question < ApplicationRecord
    has_many :questionnaire_questions, dependent: :destroy
    has_many :questionnaires, through: :questionnaire_questions
    has_many :question_items, dependent: :destroy
    has_many :items, through: :question_items, source: :item
    has_many :answers

    accepts_nested_attributes_for :question_items, allow_destroy: true

    enum question_type: { free_text: 0, simple: 1, multiple: 2 }

    validates :name, :question_type, presence: true

    scope :free_text, -> { where(question_type: 0).order(:name) }
    scope :simple,    -> { where(question_type: 1).order(:name) }
    scope :multiple,  -> { where(question_type: 2).order(:name) }

    def difficulty
      return if answers.empty? || score.to_f.zero?

      average_score = ((answers.average(:score).to_f / score) * 100).to_i

      "low" if average_score.between?(75, 100)
      "medium" if average_score.between?(31, 74)
      "high" if average_score <= 30
    rescue => e
      "can't calculate"
    end
  end
end
