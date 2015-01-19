class CreateTwilioCalls < ActiveRecord::Migration
  def change
    create_table :twilio_calls do |t|
      t.string :sid
      t.string :from
      t.string :fromCity
      t.string :fromState
      t.string :fromZip
      t.string :fromCountry

      t.timestamps null: false
    end
  end
end
