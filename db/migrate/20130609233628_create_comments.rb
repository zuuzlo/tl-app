class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
    t.string :text
    t.integer :user_id
    t.integer :post_id
    t.timestamps
    end
  end

  def down
    drop_table :comments
  end
end
