class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :user
      t.decimal :amount
      t.integer :credit_count

      t.timestamps
    end
  end
end
