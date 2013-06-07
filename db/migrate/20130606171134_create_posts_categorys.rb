class CreatePostsCategorys < ActiveRecord::Migration
  def up
    create_table :posts_categories  do |t|
      t.references :post, :category
      t.timestamps 
    end
  end

  def down
  end
end
