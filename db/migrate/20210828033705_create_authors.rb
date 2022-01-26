class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :first_name, null: false
      t.string :last_name
      t.string :middle_name

      t.references :citation, null: false, foreign_key: true, on_delete: :nullify

      t.timestamps
    end

    add_index :authors, [:last_name, :first_name]
  end
end
