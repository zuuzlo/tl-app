class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    add_column(:users, :password_digest, :string)
    remove_column(:users, :email, :group_id)
    rename_column(:users, :name, :username)

  end
end
