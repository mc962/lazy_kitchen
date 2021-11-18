class ChangeResourcesUniqueToUsers < ActiveRecord::Migration[6.1]
  def change
    # Constrain Ingredients to Users
    remove_index :ingredients, :name
    add_index :ingredients, [:name, :user_id], unique: true

    # Constraint Recipes to Users
    remove_index :recipes, :name
    add_index :recipes, [:name, :user_id], unique: true
  end
end
