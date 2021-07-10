class CreateSteps < ActiveRecord::Migration[6.1]
  def change
    create_table :steps do |t|
      t.integer :order, null: false
      t.text :instruction, null: false
      t.references :recipe, null: false, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
