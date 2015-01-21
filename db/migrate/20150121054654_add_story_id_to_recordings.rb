class AddStoryIdToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :story_id, :integer
  end
end
