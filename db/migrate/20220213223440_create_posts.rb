class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :slug
      # NOTE: content/body field is handled by action_text_rich_texts
      t.date :published_at
      t.date :modified_at
      t.boolean :published, null: false

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :posts, :title, unique: true
    add_index :posts, :slug, unique: true
  end
end
