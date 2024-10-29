class CreateOodleAnswers < ActiveRecord::Migration[8.0]
  def change
    create_table :oodle_answers do |t|
      t.datetime :answered_at, null: false
      t.json :result, null: false, default: {}
      t.decimal :score, null: false, precision: 6, scale: 2, default: 0.00
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.references :question, null: false, foreign_key: { to_table: :oodle_questions }
      t.references :questionnaire, null: false, foreign_key: { to_table: :oodle_questionnaires }

      t.timestamps
    end
  end
end
