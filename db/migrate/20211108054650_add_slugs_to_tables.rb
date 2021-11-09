class AddSlugsToTables < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :slug, :string
    add_index :recipes, :slug, unique: true

    add_column :ingredients, :slug, :string
    add_index :ingredients, :slug, unique: true
  end
end
