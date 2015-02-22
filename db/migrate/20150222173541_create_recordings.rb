class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.references :story, index: true
      t.string :url
      t.string :length
      t.text :transcript
      t.string :sid

      t.timestamps null: false
    end
    add_foreign_key :recordings, :stories
  end
end
