class CreateUniqueIds < ActiveRecord::Migration
  def change
    create_table :unique_ids do |t|

      t.timestamps null: false
    end
  end
end
