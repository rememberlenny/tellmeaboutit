class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :name
      t.string :gender
      t.integer :age
      t.string :location
      t.integer :selected_recording_id
      t.string :breakup_role
      t.text :pullquote
      t.string :breakup_type
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :stories, :users
    add_index :stories, [:user_id, :created_at]
  end
end
