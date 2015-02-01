class AddSelectedToStory < ActiveRecord::Migration
  def change
    add_column :stories, :selected_recording_id, :integer
  end
end
