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
      return errors.addd(:user, "managers can´t subscribe to questionnaires") if manager_owner?
      return errors.addd(:user, "already subscribed to this questionnaire") if subscribed?

      save user_id: user.id, questionnaire_id: questionnaire.id, start_time: Time.zone.now
    end
  end
end
