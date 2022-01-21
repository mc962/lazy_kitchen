class CreateStepIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :step_ingredients do |t|
      t.decimal :amount, null: false
      t.string :unit
      t.string :condition

      t.references :step, null: false, foreign_key: true, on_delete: :cascade
      t.references :ingredient, null: false, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
