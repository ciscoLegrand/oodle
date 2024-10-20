class CreateOodleAnswers < ActiveRecord::Migration[8.0]
  def change
    create_table :oodle_answers do |t|
      t.date :answered_at, null: false, default: -> { "CURRENT_TIMESTAMP" }
      t.jsonb :result, null: false, default: '{}'
      t.float :score, null: false, default: 0.00
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.references :question, null: false, foreign_key: { to_table: :oodle_questions }
      t.references :questionnaire, null: false, foreign_key: { to_table: :oodle_questionnaires }

      t.timestamps
    end
  end
end
