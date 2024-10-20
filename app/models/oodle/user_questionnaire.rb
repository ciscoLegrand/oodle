module Oodle
  class UserQuestionnaire < ApplicationRecord
    belongs_to :user, class_name: "::User"
    belongs_to :questionnaire, class_name: "Oodle::Questionnaire"

    has_many :answers, through: :questionnaire

    scope :completed, -> { where(completed: true, progress: 100) }
    scope :incompleted, -> { where(completed: false).where("progress < ?", 100) }

    def update_progress = update! progress: ((answers.count.to_f / questionnaire.questions.count) * 100)

    def subscribed? = persisted?

    def manager_owner? = questionnaire.manager = user

    def subscribe
      return errors.add(:user, "managers can´t subscribe to questionnaires") if manager_owner?
      return errors.add(:user, "already subscribed to this questionnaire") if subscribed?

      save user_id: user.id, questionnaire_id: questionnaire.id, start_time: Time.zone.now
    end

    private

    def update_score
      answers.each do |answer|
        next if answer.result["answer"] == "not responded" || !answer.question.scorable

        selected_answers = answer.result["selected"] || []
        answer.calculate_score(selected_answers, answer.question.items)
      end

      update! score: answers.sum(&:score)
    end
  end
end
