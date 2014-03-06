class AddPaidAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :paid_at, :datetime
  end
end
