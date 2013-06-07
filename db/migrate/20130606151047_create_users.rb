class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :group_id
      t.timestamps
    end
  end

  def down
  end
end
