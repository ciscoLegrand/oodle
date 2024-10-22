module Oodle
  class Questionnaire < ApplicationRecord
    belongs_to :manager, class_name: "::User"

    has_many :questionnaire_questions, dependent: :destroy
    has_many :questions, through: :questionnaire_questions
    has_many :user_questionnaires
    has_many :answers

    validates :name, :start_date, :end_date, :manager, presence: true
    validates :duration,
              numericality: {
                only_integer: true, greater_than_or_equal_to: 0
              }, if: -> { duration.present? }

    validate :end_date_after_start_date

    scope :sorted, -> { order(start_date: :asc) }
    scope :closed, -> { where("end_date < ?", Time.zone.now) }
    scope :opened, -> { where("start_date <= ? AND end_date >= ?", Time.zone.now, Time.zone.now) }
    scope :pending, -> { where("start_date > ?", Time.zone.now) }

    def available? = (start_date..end_date).cover?(Time.zone.now)

    def average_score = user_questionnaires.average(:score).to_f || 0.00

    def completion_percentage
      retunr 0.00 if user_questionnaires.blank?

      percentage = (user_questionnaires.completed.count.to_f / user_questionnaires.count) * 100
      percentage.round(2)
    end

    private

    def end_date_after_start_date
      return if start_date < end_date

      errors.add(:end_date, "must be after the start date")
    end
  end
end
