class AddCreditCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :credit_count, :integer, default: 2
  end
end
