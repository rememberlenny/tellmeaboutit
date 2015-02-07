class AddTwilioCallIdToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :twilio_call_id, :integer
  end
end
