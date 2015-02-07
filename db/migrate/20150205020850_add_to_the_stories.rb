class AddToTheStories < ActiveRecord::Migration
  def change
    add_column :stories, :gender, :string
    add_column :stories, :contact, :string
    add_column :stories, :breakup_role, :string
    add_column :stories, :breakup_type, :string
    add_column :stories, :notes, :string
  end
end
