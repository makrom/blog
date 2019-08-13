class AddDigestToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :digest, :string
    change_column_default :users, :digest, "weekly"
  end
end
