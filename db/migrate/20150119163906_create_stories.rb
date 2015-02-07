class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.integer :recording_id
      t.string :name
      t.string :person
      t.timestamps null: false
    end
  end
end
