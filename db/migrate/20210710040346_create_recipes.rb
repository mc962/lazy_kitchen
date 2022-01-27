class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.string :image_url
      t.text :description
      t.boolean :publicly_accessible, null: false, default: false

      t.timestamps
    end

    add_index :recipes, :name, unique: true # TODO index on user id as well, only needs to be unique within user
  end
end
