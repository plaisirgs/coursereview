class AddCredentials < ActiveRecord::Migration
  def change
      add_column :users, :email_address, :string
      add_column :users, :password_digest, :string
  end
end
