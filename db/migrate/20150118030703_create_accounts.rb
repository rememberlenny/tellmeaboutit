class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :uid, :unique => true
      t.timestamps null: false
    end
  end
end
