class AddColumnsToPost < ActiveRecord::Migration
  def change
    rename_column :posts, :post, :title
    add_column :posts, :description, :string
    add_column :posts, :url, :string
  end
end
