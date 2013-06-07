class RemoveFieldnameFormPost < ActiveRecord::Migration
  def up
    remove_column :posts, :fieldname, :category_id
  end

  def down
  end
end
