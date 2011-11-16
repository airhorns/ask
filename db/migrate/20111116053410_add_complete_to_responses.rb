class AddCompleteToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :complete, :boolean
  end
end
