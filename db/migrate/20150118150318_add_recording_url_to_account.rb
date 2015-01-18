class AddRecordingUrlToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :recording_length, :string
    add_column :accounts, :recording_url, :string
  end
end
