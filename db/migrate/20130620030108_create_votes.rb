class CreateVotes < ActiveRecord::Migration
  def up
    create_table :votes do |t|
      t.boolean :vote
      t.references :voteable, polymophic: true
      t.integer :user_id
      t.string   :voteable_type
      t.timestamps
    end
  end
  
  def down
    drop_table :votes
  end
end
