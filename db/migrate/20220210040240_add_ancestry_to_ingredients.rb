class AddAncestryToIngredients < ActiveRecord::Migration[7.0]
  def change
    add_column :ingredients, :ancestry, :string
    add_index :ingredients, :ancestry, order: {slug: :text_pattern_ops}
  end
end
