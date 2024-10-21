class CreateOodleQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :oodle_questions do |t|
      t.string :name, null: false
      t.text :description
      t.integer :question_type, null: false
      t.boolean :scorable, null: false, default: false
      t.decimal :score, precision: 6, scale: 3
      t.text :explanation

      t.timestamps
    end
  end
end
