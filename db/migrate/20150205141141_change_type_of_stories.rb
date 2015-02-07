class ChangeTypeOfStories < ActiveRecord::Migration
  def change
    remove_column :stories, :notes, :string
    add_column :stories, :notes, :text
  end
end
