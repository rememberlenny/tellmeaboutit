class CreateTextthreads < ActiveRecord::Migration
  def change
    create_table :textthreads do |t|
      t.integer :user_id
      t.integer :story_id
      t.string :state

      t.timestamps null: false
    end
  end
end
