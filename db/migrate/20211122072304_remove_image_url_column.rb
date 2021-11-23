class RemoveImageUrlColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :recipes, :image_url
  end
end
