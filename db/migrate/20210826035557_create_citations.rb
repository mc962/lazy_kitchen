class CreateCitations < ActiveRecord::Migration[6.1]
  def change
    create_table :citations do |t|
      t.string :origin, null: false
      t.string :content_type, null: false

      t.string :publication_title # title of print-page/site-page where Recipe was published
      t.string :publication_location # location (generally print-page) where Recipe was published
      t.string :publisher # organization/institution (generally print-page) who published Recipe
      t.date :published_at # date/time when Recipe was published
      t.string :content_location # location in book, page, etc. where Recipe was published

      t.string :version # specific version generally print-page) where Recipe was published
      t.string :site_title # title of overall web site where Recipe was published
      t.date :last_accessed_at # last date/time Recipe was accessed at (generally site-page)
      t.string :site_link # link to web site/page where Recipe was published

      t.references :recipe, null: false, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
