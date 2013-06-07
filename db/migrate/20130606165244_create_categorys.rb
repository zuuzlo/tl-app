class CreateCategorys < ActiveRecord::Migration
  def up
    create_table :categories do |t| 
      t.string :category
      t.timestamps 
    end
  end

  def down
  end
end
