class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.string :image_url
      t.text :description

      t.timestamps
    end

    add_index :recipes, :name, unique: true
  end
end
