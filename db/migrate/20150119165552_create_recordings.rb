class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.string :url
      t.string :length
      t.string :transcript
      t.integer :twilio_id

      t.timestamps null: false
    end
  end
end
