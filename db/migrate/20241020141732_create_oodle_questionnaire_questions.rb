class CreateOodleQuestionnaireQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :oodle_questionnaire_questions do |t|
      t.references :questionnaire, null: false, foreign_key: { to_table: :oodle_questionnaires }
      t.references :question, null: false, foreign_key: { to_table: :oodle_questions }

      t.timestamps
    end
  end
end
