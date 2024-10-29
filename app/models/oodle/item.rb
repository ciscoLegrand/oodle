module Oodle
  class Item < ApplicationRecord
    has_many :question_items, class_name: "Oodle::QuestionItem", foreign_key: "item_id", dependent: :nullify
    has_many :questions, through: :question_items
    validates :name, :description, :score, presence: true

    def used? = QuestionItem.where(item_id: id).present?
  end
end
