class AddAncestryToIngredients < ActiveRecord::Migration[7.0]
  def change
    add_column :ingredients, :ancestry, :string
    # text_pattern_ops is a recommended optimization of the ancestry column index: https://github.com/stefankroes/ancestry
    add_index :ingredients, :ancestry, order: {ancestry: :text_pattern_ops}
  end
end
