class AddDatesToStory < ActiveRecord::Migration
  def change
    add_column :stories, :start_dating, :date
    add_column :stories, :end_dating, :date
  end
end
