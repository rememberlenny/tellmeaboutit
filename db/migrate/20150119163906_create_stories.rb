class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.text :transcript
      t.string :name
      t.integer :recording_id
      t.integer :details_id
      t.timestamps null: false
    end
  end
end
