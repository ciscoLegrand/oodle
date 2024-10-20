class CreateOodleQuestionItems < ActiveRecord::Migration[8.0]
  def change
    create_table :oodle_question_items do |t|
      t.references :question, null: false, foreign_key: { to_table: :oodle_questions }
      t.references :item, null: false, foreign_key: { to_table: :oodle_items }

      t.timestamps
    end
  end
end
