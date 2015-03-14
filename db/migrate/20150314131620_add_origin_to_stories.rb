class AddOriginToStories < ActiveRecord::Migration
  def change
    add_column :stories, :origin, :string
  end
end
