class CreateOodleItems < ActiveRecord::Migration[8.0]
  def change
    create_table :oodle_items do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :group
      t.decimal :score, null: false, precision: 6, scale: 3, default: 0
      t.string :display_value
      t.string :correct_value
      t.boolean :editable, null: false, default: false

      t.timestamps
    end
  end
end
