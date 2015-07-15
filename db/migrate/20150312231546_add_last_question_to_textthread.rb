class AddLastQuestionToTextthread < ActiveRecord::Migration
  def change
    add_column :textthreads, :last_question, :string
  end
end
