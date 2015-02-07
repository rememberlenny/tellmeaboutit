class RemoveTheTypeOfBreakup < ActiveRecord::Migration
  def change
    remove_column :stories, :breakup_type, :string
  end
end
