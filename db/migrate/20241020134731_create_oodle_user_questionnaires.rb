class CreateOodleUserQuestionnaires < ActiveRecord::Migration[8.0]
  def change
    create_table :oodle_user_questionnaires do |t|
      t.decimal :score, null: false, precision: 6, scale: 3, default: 0
      t.decimal :progress, null: false, precision: 6, scale: 3, default: 0
      t.boolean :completed, null: false, default: false
      t.datetime :started_at, null: false, default: -> { "CURRENT_TIMESTAMP" }
      t.datetime :completed_at
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.references :questionnaire, null: false, foreign_key: { to_table: :oodle_questionnaires }

      t.timestamps
    end
  end
end
