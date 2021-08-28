class CreateCitations < ActiveRecord::Migration[6.1]
  def change
    create_table :citations do |t|
      t.string :origin, null: false
      t.string :content_type, null: false

      t.string :additional_contributors, array: true
      t.string :publication_title
      t.string :publication_location
      t.string :publisher
      t.date :published_at
      t.string :content_location

      t.string :site_title
      t.string :version
      t.date :last_accessed_at
      t.string :site_link

      t.references :recipe, null: false, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
