class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :uid
      t.timestamps null: false
    end
  end
end
