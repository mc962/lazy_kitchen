class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end

    add_index :ingredients, :name, unique: true # TODO index on user id as well, only needs to be unique within user
  end
end
