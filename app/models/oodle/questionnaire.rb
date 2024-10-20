module Oodle
  class Questionnaire < ApplicationRecord
    belongs_to :manager, class_name: "::User"

    has_many :questionnaire_questions, dependent: :destroy
    has_many :questions, through: :questionnaire_questions

    validates :name, :start_date, :end_date, :manager, presence: true
    validates :duration,
              numericality: {
                only_integer: true, greater_than_or_equal_to: 0
              }, if: -> { duration.present? }

    validate :end_date_after_start_date

    def available? = (start_date..end_date).cover?(Time.zone.now)

    private

    def end_date_after_start_date
      return if start_date < end_date

      errors.add(:end_date, "must be after the start date")
    end
  end
end
