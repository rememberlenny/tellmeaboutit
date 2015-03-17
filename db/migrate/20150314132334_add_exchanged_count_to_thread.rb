class AddExchangedCountToThread < ActiveRecord::Migration
  def change
    add_column :texthread, :exchange_count, :integer
  end
end
