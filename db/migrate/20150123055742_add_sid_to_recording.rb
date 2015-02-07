class AddSidToRecording < ActiveRecord::Migration
  def change
    add_column :recordings, :sid, :string
  end
end
