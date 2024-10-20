class CreateOodleQuestionnaires < ActiveRecord::Migration[8.0]
  def change
    create_table :oodle_questionnaires do |t|
      t.string :name, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.integer :duration
      t.references :manager, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
