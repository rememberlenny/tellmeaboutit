class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.references :story, index: true
      t.string :url
      t.string :source

      t.timestamps null: false
    end
    add_foreign_key :recordings, :stories
    add_index :recordings, [:story_id, :created_at]
  end
end
