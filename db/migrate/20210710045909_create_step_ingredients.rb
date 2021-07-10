class CreateStepIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :step_ingredients, primary_key: [:step_id, :ingredient_id] do |t|
      t.references :step, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true
      t.decimal :amount, null: false
      t.string :unit
      t.string :condition

      t.timestamps
    end
  end
end
