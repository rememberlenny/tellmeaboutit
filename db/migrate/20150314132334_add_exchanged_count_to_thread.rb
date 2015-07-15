class AddExchangedCountToThread < ActiveRecord::Migration
  def change
    add_column :textthreads, :exchange_count, :integer
  end
end
