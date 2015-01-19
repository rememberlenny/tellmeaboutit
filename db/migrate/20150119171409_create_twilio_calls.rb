class CreateTwilioCalls < ActiveRecord::Migration
  def change
    create_table :twilio_calls do |t|
      t.string :sid
      t.string :from
      t.string :FromCity
      t.string :FromState
      t.string :FromZip
      t.string :FromCountry

      t.timestamps null: false
    end
  end
end
