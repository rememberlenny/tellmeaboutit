class AddStoryPullQuote < ActiveRecord::Migration
  def change
    add_column :stories, :pullquote, :string
  end
end
