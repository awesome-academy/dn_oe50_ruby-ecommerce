class AddRememberDigestToAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :remember_digest, :string
  end
end
