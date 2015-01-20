class AddAttributesToStories < ActiveRecord::Migration
  def change
    add_column :stories, :age, :integer
    add_column :stories, :location, :string
    add_column :stories, :was_checked, :boolean, :default => false
  end
end
